//
//  RecipeDto.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 31/10/21.
//

import Foundation

struct RecipeDto: Codable, Equatable {
    var pk: Int?
    var title: String?
    var publisher: String?
    var featuredImage: String?
    var rating: Int?
    var sourceUrl: String?
    var ingredients: [String]?
    var longDateAdded: Int64?
    var longDateUpdated: Int64?
    
    enum CodingKeys: String, CodingKey {
        case pk = "pk"
        case title = "title"
        case publisher = "publisher"
        case featuredImage = "featured_image"
        case rating = "rating"
        case sourceUrl = "source_url"
        case ingredients = "ingredients"
        case longDateAdded = "long_date_added"
        case longDateUpdated = "long_date_updated"
    }
}
