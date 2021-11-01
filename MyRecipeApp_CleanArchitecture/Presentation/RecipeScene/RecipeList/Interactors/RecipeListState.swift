//
//  RecipeListState.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

struct RecipeListState {
    let isLoading: Bool
    let page: Int
    let query: String
    let recipeList: [RecipeDto]
    // TODO: - Add Search properties here.
    
    init(isLoading: Bool = false,
         page: Int = 1,
         query: String = "",
         recipeList: [RecipeDto] = []
    ){
        self.isLoading = isLoading
        self.page = page
        self.query = query
        self.recipeList = recipeList
    }
    
    func copy(isLoading: Bool? = nil,
              page: Int? = nil,
              query: String? = nil,
              recipeList: [RecipeDto]? = nil
    ) -> RecipeListState {
        return RecipeListState (
            isLoading: isLoading ?? self.isLoading,
            page: page ?? self.page,
            query: query ?? self.query,
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
