//
//  AppDelegate.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @Injected(\.mainNavController)
    var mainNavController: UINavigationController
    @Injected(\.mainCoordinator)
    var mainCoordinator: MainCoordinator
    var window: UIWindow?
    
    /**
     At this point since we use coordinator pattern we have
     to instantiate coordinator in didFinishLaunchingWithOptions
     and to disable Storyboard default launch.
     
     #SOS!!!
     In order to run MainCoordinator successfully we have to go and remove
     main from main interface option in project settings
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        mainCoordinator.start()
        
        // create a base UIWindow and activate it
        window = BaseWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavController
        window?.makeKeyAndVisible()
        
        return true
    }
}

