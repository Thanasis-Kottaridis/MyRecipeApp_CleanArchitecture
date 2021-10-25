//
//  Recipe.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

struct Recipe: Codable, Equatable {
    var id: Int?
    var name: String?
    var price: String?
    var thumbnail: String?
    var image: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "Name"
        case price = "Price"
        case thumbnail = "Thumbnail"
        case image = "Image"
        case description = "Description"
    }
}
