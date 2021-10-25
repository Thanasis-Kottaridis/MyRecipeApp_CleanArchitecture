//
//  RecipeListState.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

struct RecipeListState {
    let isLoading: Bool
    let recipeList: [Recipe]
    let feedBack: FeedbackMessage?
    // TODO: - Add Search properties here.
    
    init(isLoading: Bool = false,
         recipeList: [Recipe] = [],
         feedBack: FeedbackMessage? = nil
    ){
        self.isLoading = isLoading
        self.recipeList = recipeList
        self.feedBack = feedBack
    }
    
    func copy(isLoading: Bool? = nil,
              recipeList: [Recipe]? = nil,
              feedBack: FeedbackMessage? = nil
    ) -> RecipeListState {
        return RecipeListState (
            isLoading: isLoading ?? self.isLoading,
            recipeList: recipeList ?? self.recipeList,
            feedBack: feedBack ?? self.feedBack
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
