//
//  RecipeListState.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import Domain

struct RecipeListState {
    let isLoading: Bool
    let recipeList: [Recipe]
    // TODO: - Add Search properties here.
    
    init(isLoading: Bool = false,
         recipeList: [Recipe] = []
    ){
        self.isLoading = isLoading
        self.recipeList = recipeList
    }
    
    func copy(isLoading: Bool? = nil,
              recipeList: [Recipe]? = nil
    ) -> RecipeListState {
        return RecipeListState (
            isLoading: isLoading ?? self.isLoading,
            recipeList: recipeList ?? self.recipeList
        )
    }
}

enum RecipeListEvents {
    case fetchRecipes
    case refreshRecipes
    case queryRecipes(query: String)
    case goToDetails(recipe: Recipe)
    case presentFeedback(message: FeedbackMessage)
}
