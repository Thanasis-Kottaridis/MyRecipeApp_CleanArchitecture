//
//  Recipe.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

struct Recipe: Codable {
    let id: Int?
    let name: String?
    let price: String?
    let thumbnail: String?
    let image: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "Name"
        case price = "Price"
        case thumbnail = "Thumbnail"
        case image = "Image"
        case description = "Description"
    }
}
