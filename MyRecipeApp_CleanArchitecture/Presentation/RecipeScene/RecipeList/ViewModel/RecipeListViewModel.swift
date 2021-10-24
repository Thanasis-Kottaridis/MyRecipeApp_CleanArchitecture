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
    /// Inject RecipeList UseCase
    @Injected(\.recipeListUseCase)
    private var useCase: RecipeListUseCase
    
    /**
        Encapsulate state in viewModel
        And expose only stateObserver to ViewController
     */
    private var state: BehaviorRelay<RecipeListState>
    var stateObserver: Observable<RecipeListState> {
        return state.asObservable()
    }
    
    init(recipeActionHandler: RecipeActionHandler) {
        // init ViewModel with default state.
        state = BehaviorRelay(value: RecipeListState())
        // register action handler
        self.recipeActionHandler = recipeActionHandler
    }
    
    func onTriggeredEvent(event: RecipeListEvents) {
        switch event {
        case .fetchRecipes:
            fetchRecipes()
        case .refreshRecipes:
            break
        case .queryRecipes:
            break
        case .goToDetails:
            recipeActionHandler.handleAction(action: .GO_TO_RECIPE_DETAILS)
        }
    }
    
    private func fetchRecipes() {
        // set state to loading state
        self.state.accept(state.value.copy(isLoading: true))
        
        useCase.execute { [weak self] recipeList in
            guard let self = self else { return }

            self.state.accept(self.state.value.copy(
                isLoading: false,
                recipeList: recipeList,
                feedBack: FeedbackMessage(message: "Message Fetch from storage", type: .success)))
            
            debugPrint("Message Fetch from storage")
        } completion: { [weak self]  recipeList in
            guard let self = self else { return }

            self.state.accept(self.state.value.copy(
                isLoading: false,
                recipeList: recipeList,
                feedBack: FeedbackMessage(message: "Message Fetch from network", type: .success)))
            debugPrint("Message Fetch from network")
            
        } errorCompletion: { [weak self] errorMessage in
            guard let self = self else { return }
            
            self.state.accept(self.state.value.copy(
                isLoading: false,
                feedBack: errorMessage
            ))
                               
            debugPrint(errorMessage.message)
        }
    }
}

