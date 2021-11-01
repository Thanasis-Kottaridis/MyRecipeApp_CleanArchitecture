//
//  RecipeRepository.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

protocol RecipeRepository {
    func fetchRecipes(page: Int,
                      query: String,
                      forceReload: Bool,
                      cached: @escaping (RecipeSearchResponse)-> Void,
                      completion: @escaping (RecipeSearchResponse)-> Void,
                      errorCompletion: @escaping (Error?)-> Void)
    
    func queryRecipes(query: String,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void)
        
}
