//
//  ArtistModel.swift
//  testSimplefield_FRD
//
//  Created by ac1ra on 24/11/2018.
//  Copyright © 2018 ac1ra. All rights reserved.
//

import Foundation
class ArtistModel{
    var id: String?
    var name: String?
    var genre: String?
    
    init(id:String?,name: String?, genre: String?) {
        self.id = id
        self.name = name
        self.genre = genre
    }
}
