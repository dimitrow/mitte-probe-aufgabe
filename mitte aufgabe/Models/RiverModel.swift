//
//  RiverModel.swift
//  mitte aufgabe
//
//  Created by Gene Dimitrow on 22.08.21.
//

import Foundation

struct RiverModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image"
        case length
        case message
    }
    
    let name: String
    let imageURL: String
    let length: RiverLengthModel
    var message: String?
}
