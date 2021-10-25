//
//  RecipeDetailsViewModel.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 25/10/21.
//

import Foundation
import RxSwift
import RxCocoa

class RecipeDetailsViewModel: RecipeActionDispatcher {
    
    var recipeActionHandler: RecipeActionHandler
    
    /**
        Encapsulate state in viewModel
        And expose only stateObserver to ViewController
     */
    private var state: BehaviorRelay<RecipeDetailsState>
    var stateObserver: Observable<RecipeDetailsState> {
        return state.asObservable()
    }
    
    init(recipe: Recipe, recipeActionHandler: RecipeActionHandler) {
        state = BehaviorRelay(value: RecipeDetailsState(selectedRecipe: recipe))
        // register action handler
        self.recipeActionHandler = recipeActionHandler
    }
    
    func onTriggeredEvent(event: RecipeDetailsEvents) {
        switch event {
        case .pop:
            recipeActionHandler.handleAction(action: .POP)
        }
    }
}
