//
//  VCTableViewCell.swift
//  testSimplefield_FRD
//
//  Created by ac1ra on 24/11/2018.
//  Copyright © 2018 ac1ra. All rights reserved.
//

import UIKit

class VCTableViewCell: UITableViewCell {

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
