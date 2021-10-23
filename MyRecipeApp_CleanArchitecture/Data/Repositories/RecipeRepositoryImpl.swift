//
//  RecipeRepositoryImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

final class RecipeRepositoryImpl: RecipeRepository {
    
    func fetchRecipes(
        cached: @escaping (RecipeList) -> Void,
        completion: @escaping (Result<RecipeList, Error>) -> Void
    ) {
        
    }
    
    
}
