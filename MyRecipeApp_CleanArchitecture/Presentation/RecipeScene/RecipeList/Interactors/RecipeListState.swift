//
//  RecipeListState.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

struct RecipeListState {
    let isLoading: Bool
    let recipeList: [RecipeList]
    // TODO: - Add Search properties here.
    
    init(isLoading: Bool = false, recipeList: [RecipeList] = []){
        self.isLoading = isLoading
        self.recipeList = recipeList
    }
    
    func copy(isLoading: Bool? = nil, recipeList: [RecipeList]? = nil) -> RecipeListState {
        return RecipeListState (
            isLoading: isLoading ?? self.isLoading,
            recipeList: recipeList ?? self.recipeList
        )
    }
}

enum RecipeListEvents {
    case fetchRecipes
    case refreshRecipes
    case queryRecipes
    case goToDetails
}
