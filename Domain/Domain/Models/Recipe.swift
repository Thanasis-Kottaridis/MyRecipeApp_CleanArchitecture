//
//  Recipe.swift
//  Domain
//
//  Created by thanos kottaridis on 2/11/21.
//

import Foundation

public struct Recipe: Codable, Equatable {
    
    public var id: Int?
    public var name: String?
    public var price: String?
    public var thumbnail: String?
    public var image: String?
    public var description: String?
    
    public init(id: Int? = nil, name: String? = nil, price: String? = nil, thumbnail: String? = nil, image: String? = nil, description: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.thumbnail = thumbnail
        self.image = image
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "Name"
        case price = "Price"
        case thumbnail = "Thumbnail"
        case image = "Image"
        case description = "Description"
    }
}
