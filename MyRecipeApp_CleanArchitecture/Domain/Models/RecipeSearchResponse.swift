//
//  RecipeSearchResponse.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 31/10/21.
//

import Foundation

struct RecipeSearchResponse: Codable {
    var count: Int
    var results: [RecipeDto]
}
