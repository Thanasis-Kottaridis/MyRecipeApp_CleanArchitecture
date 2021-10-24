//
//  RecipeRepository.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

protocol RecipeRepository {
    func fetchRecipes(cached: @escaping ([Recipe])-> Void,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void
    )
}
