//
//  MainCoordinator.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        // In MainCoordinator we can check if user needs to login,
        // if yes we would run login flow
        
        // start recipe Coordinator
        let recipeCoord = RecipeCoordinator(navigationController: navigationController)
        recipeCoord.start()
    }
    
    func goToRecipeDetails(){
        
    }
    
}

