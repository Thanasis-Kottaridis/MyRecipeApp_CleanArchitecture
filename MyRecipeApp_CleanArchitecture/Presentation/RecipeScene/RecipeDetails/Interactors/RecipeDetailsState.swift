//
//  RecipeDetailsState.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 25/10/21.
//

import Foundation
import Domain

struct RecipeDetailsState {
    let isLoading: Bool
    let selectedRecipe: Recipe
    let feedBack: FeedbackMessage?
    
    init(isLoading: Bool = false,
         selectedRecipe: Recipe = Recipe(),
         feedBack: FeedbackMessage? = nil
    ){
        self.isLoading = isLoading
        self.selectedRecipe = selectedRecipe
        self.feedBack = feedBack
    }
    
    func copy(isLoading: Bool? = nil,
              selectedRecipe: Recipe? = nil,
              feedBack: FeedbackMessage? = nil
    ) -> RecipeDetailsState {
        return RecipeDetailsState (
            isLoading: isLoading ?? self.isLoading,
            selectedRecipe: selectedRecipe ?? self.selectedRecipe,
            feedBack: feedBack ?? self.feedBack
        )
    }
}

enum RecipeDetailsEvents {
    case pop
}
