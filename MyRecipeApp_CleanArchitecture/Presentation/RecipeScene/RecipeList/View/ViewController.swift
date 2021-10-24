//
//  ViewController.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController, Storyboarded {

    @Injected(\.recipeRepository)
    var recipeRepository: RecipeRepository
    @Injected(\.recipeStorageProvider)
    private var cache: RecipeStorage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeRepository.fetchRecipes { recipeList in
            print("Response completed from cache")
        } completion: { responseResult in
            print("Response completed from network")
        } errorCompletion: { error in
            print("error called from VC")
        }
    }
}

