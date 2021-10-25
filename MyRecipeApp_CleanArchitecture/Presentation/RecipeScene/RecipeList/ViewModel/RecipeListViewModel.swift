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
            fetchRecipes(forceReload: true)
        case .queryRecipes(let query):
            queryRecipes(query: query)
        case .goToDetails(let recipe):
            recipeActionHandler.handleAction(action: .GO_TO_RECIPE_DETAILS(recipe: recipe))
        case .presentFeedback(let message):
            recipeActionHandler.handleAction(action: .PRESENT_FEEDBACK(feedbackMessage: message))
        }
    }
    
    private func fetchRecipes(forceReload: Bool = false) {
        // set state to loading state
        self.state.accept(state.value.copy(isLoading: true))
        
        useCase.execute (forceReload: forceReload)
        { [weak self] recipeList in
            guard let self = self else { return }

            let feedback = FeedbackMessage(message: NSLocalizedString("FetchFromStorageFeedback", comment: ""),
                                           type: .success)
            self.state.accept(self.state.value.copy(
                isLoading: false,
                recipeList: recipeList,
                feedBack: feedback))
            self.onTriggeredEvent(event: .presentFeedback(message: feedback))
            debugPrint(feedback.message)
        } completion: { [weak self]  recipeList in
            guard let self = self else { return }

            let feedback = FeedbackMessage(message: NSLocalizedString("FetchFromNetworkFeedback", comment: ""),
                                           type: .success)
            self.state.accept(self.state.value.copy(
                isLoading: false,
                recipeList: recipeList,
                feedBack: feedback))
            
            self.onTriggeredEvent(event: .presentFeedback(message: feedback))
            debugPrint(feedback.message)

        } errorCompletion: { [weak self] errorMessage in
            guard let self = self else { return }
            
            self.state.accept(self.state.value.copy(
                isLoading: false,
                feedBack: errorMessage
            ))
            self.onTriggeredEvent(event: .presentFeedback(message: errorMessage))
            debugPrint(errorMessage.message)
        }
    }
    
    private func queryRecipes(query: String){
        self.state.accept(state.value.copy(isLoading: true))

        useCase.queryRecipes(query: query) { recipeList in
            self.state.accept(self.state.value.copy(
                isLoading: false,
                recipeList: recipeList,
                feedBack: nil))
        } errorCompletion: { errorMessage in
            self.state.accept(self.state.value.copy(
                isLoading: false,
                feedBack: errorMessage
            ))
            
            self.onTriggeredEvent(event: .presentFeedback(message: errorMessage))
            debugPrint(errorMessage.message)
        }

    }
}

