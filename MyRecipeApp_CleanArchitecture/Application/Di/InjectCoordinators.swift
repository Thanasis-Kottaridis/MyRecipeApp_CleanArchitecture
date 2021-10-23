//
//  InjectCoordinators.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit


private struct MainNavControllerProviderKey: InjectionKey {
    static var currentValue: UINavigationController = UINavigationController()
}

private struct MainCoordinatorProviderKey: InjectionKey {
    static var currentValue: MainCoordinator =
    MainCoordinator(navigationController: InjectedValues[\.mainNavController])
}

private struct RecipeCoordinatorProviderKey: InjectionKey {
    @Injected(\.mainNavController) var mainNavController: UINavigationController
    static var currentValue: RecipeCoordinator =
    RecipeCoordinator(navigationController: InjectedValues[\.mainNavController])

}

/**
    For every Injected Value we have to create a computed property of its Provider in order to have access on getting and setting method
    **Self:** Here referring to the working Extension
    **Provider.self:** here provides Provider type (that conforms InjectionKey) to InjectedValues key subscript.
 */
extension InjectedValues {
    /// Get Only property mainNavController.
    /// This property is initialized once in app delegate at the app boot.
    var mainNavController: UINavigationController {
        get { Self[MainNavControllerProviderKey.self]}
        set { Self[MainNavControllerProviderKey.self] = newValue }
    }
    
    var mainCoordinator: MainCoordinator {
        get { Self[MainCoordinatorProviderKey.self]}
        set { Self[MainCoordinatorProviderKey.self] = newValue }
    }
    
    var recipeCoordinator: RecipeCoordinator {
        get { Self[RecipeCoordinatorProviderKey.self]}
        set { Self[RecipeCoordinatorProviderKey.self] = newValue }
    }
}
