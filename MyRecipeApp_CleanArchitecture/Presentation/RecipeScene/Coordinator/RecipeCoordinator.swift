//
//  RecipeCoordinator.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit

enum RecipeNavActions {
    case POP
    case GO_TO_RECIPE_DETAILS(recipe: Recipe)
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
        //
        let recipeListViewModel = RecipeListViewModel(recipeActionHandler: self)
        let vc = RecipeListVC(viewModel: recipeListViewModel)
        navigationController.pushViewController(vc, animated: false)
    }
}

//MARK: - Nav Actions EXT
extension RecipeCoordinator: RecipeActionHandler {
    func handleAction(action: RecipeNavActions) {
        switch action {
        case .POP:
            break
        case .GO_TO_RECIPE_DETAILS:
            debugPrint("GO_TO_RECIPE_DETAILS Action")
            break
        }
    }
}
