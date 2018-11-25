//
//  ViewController.swift
//  testSimplefield_FRD
//
//  Created by ac1ra on 24/11/2018.
//  Copyright © 2018 ac1ra. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var refArtists: DatabaseReference!
    
    @IBOutlet var textFieldName: UITextField!
    @IBOutlet var textFieldGenre: UITextField!
    @IBOutlet var messLabel: UILabel!
    
    @IBOutlet var tableViewArtists: UITableView!
    
    var artList = [ArtistModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
        let artist: ArtistModel
        
        artist = artList[indexPath.row]
        
        cell.labelName.text = artist.name
        cell.labelGenre.text = artist.genre
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = artList[indexPath.row]
        let alertController = UIAlertController(title: artist.name, message: "Give new values to update", preferredStyle: .alert)
        
        let confirmAlert = UIAlertAction(title: "Enter", style: .default){(_) in
            let id = artist.id
            
            let name = alertController.textFields?[0].text
            let genre = alertController.textFields?[1].text
            
            self.updateArtist(id: id!,name: name!,genre: genre!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){(_) in
            //deleting artist
            self.deleteArtist(id: artist.id!)
        }
            //adding two textfields to alert
        alertController.addTextField{ (textField) in
                textField.text = artist.name
        }
        alertController.addTextField{ (textField) in
                textField.text = artist.genre
        }
            //adding action
        alertController.addAction(confirmAlert)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func bttnAdd(_ sender: UIButton) {
        addArtist()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        refArtists = Database.database().reference().child("artists")
        
        refArtists.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0{
                //clearing the list
                self.artList.removeAll()
                
                for artists in snapshot.children.allObjects as! [DataSnapshot]{
                    let artObject = artists.value as? [String: AnyObject]
                    let artName = artObject?["artistName"]
                    let artId = artObject?["id"]
                    let artGenre = artObject?["artistGenre"]
                
                    let artist = ArtistModel(id: artId as! String?, name: artName as! String?, genre: artGenre as! String?)
                    self.artList.append(artist)
                }
                self.tableViewArtists.reloadData()
            }
        })
    }

    func addArtist(){
        let key = refArtists.childByAutoId().key
        
        let art = ["id": key,
                   "artistName":textFieldName.text! as String,
                   "artistGenre":textFieldGenre.text! as String
                   ]
        refArtists.child(key).setValue(art)
        //displaying message
        messLabel.text = "Artist added"
    }
    func updateArtist(id: String, name: String, genre: String) {
        //creating artist with the new given values
        let artist = ["id": id,
                      "artistName": name,
                      "artistGenre": genre
                      ]
        //updating the artist using the key of the artist
        refArtists.child(id).setValue(artist)
        
        //displaying message
        messLabel.text = "Artist Updated"
    }
    func deleteArtist(id:String) {
        refArtists.child(id).setValue(nil)
        //displaying message
        messLabel.text = "Artist Deleted"
    }
}
