//
//  RecipeListViewModel.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeListViewModel: RecipeActionDispatcher {
    
    // MARK: - Vars
    /// this helper var is used to perform actions  to coordinator
    var recipeActionHandler: RecipeActionHandler
    
    init(recipeActionHandler: RecipeActionHandler) {
        self.recipeActionHandler = recipeActionHandler
    }
}
