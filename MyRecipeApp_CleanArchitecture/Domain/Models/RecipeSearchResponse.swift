//
//  RecipeSearchResponse.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 31/10/21.
//

import Foundation

struct RecipeSearchResponse: Codable {
    var count: Int = 0
    var results: [RecipeDto]?
    var next: String?
    var previous: String?
}
