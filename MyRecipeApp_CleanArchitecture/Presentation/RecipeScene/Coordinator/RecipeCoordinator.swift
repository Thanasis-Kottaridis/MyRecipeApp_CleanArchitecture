//
//  RecipeCoordinator.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit
import Domain

enum RecipeNavActions {
    case POP
    case GO_TO_RECIPE_DETAILS(recipe: Recipe)
    case PRESENT_FEEDBACK(feedbackMessage: FeedbackMessage)
}

/** This protocol must be conformed from Coordinator in order to handle coordinator actions */
protocol RecipeActionHandler: AnyObject {
    func handleAction(action: RecipeNavActions)
}

/** This protocol must be conformed from ViewModels in order to handle coordinator actions */
protocol RecipeActionDispatcher: AnyObject {
    var recipeActionHandler: RecipeActionHandler { get set }
}

class RecipeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let recipeListViewModel = RecipeListViewModel(recipeActionHandler: self)
        let vc = RecipeListVC(viewModel: recipeListViewModel)
        navigationController.pushViewController(vc, animated: false)
    }
}

//MARK: - Nav Actions EXT
extension RecipeCoordinator: RecipeActionHandler {
    func handleAction(action: RecipeNavActions) {
        switch action {
        /// # BASE ACTIONS
        case .POP:
            break
        case .PRESENT_FEEDBACK(let feedbackMessage):
            DispatchQueue.main.async {
                (UIApplication.shared.keyWindow as? BaseWindow)?
                    .presentingFeedbackMessage(feedBack: feedbackMessage)
            }
            
        /// # NAV ACTIONS
        case .GO_TO_RECIPE_DETAILS(let recipe):
            let viewModel = RecipeDetailsViewModel(recipe: recipe, recipeActionHandler: self)
            let vc = RecipeDetailsVC(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
