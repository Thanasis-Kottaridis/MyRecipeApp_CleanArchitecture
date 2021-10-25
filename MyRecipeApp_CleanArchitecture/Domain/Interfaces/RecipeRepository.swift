//
//  RecipeRepository.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

protocol RecipeRepository {
    func fetchRecipes(forceReload: Bool,
                      cached: @escaping ([Recipe])-> Void,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void
    )
    
    func queryRecipes(query: String,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void)
        
}
