//
//  RecipeRepository.swift
//  Domain
//
//  Created by thanos kottaridis on 2/11/21.
//

import Foundation

public protocol RecipeRepository {
    func fetchRecipes(forceReload: Bool,
                      cached: @escaping ([Recipe])-> Void,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void
    )
    
    func queryRecipes(query: String,
                      completion: @escaping ([Recipe])-> Void,
                      errorCompletion: @escaping (Error?)-> Void)
        
}
