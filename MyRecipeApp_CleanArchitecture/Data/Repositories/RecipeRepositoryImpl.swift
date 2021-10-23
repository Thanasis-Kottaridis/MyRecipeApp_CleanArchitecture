//
//  RecipeRepositoryImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

final class RecipeRepositoryImpl: RecipeRepository {
    
    let sessionManager: Session = InjectedValues[\.networkProvider].manager
    
    func fetchRecipes(
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (AFError)-> Void
    ) {
        
        let _ = sessionManager.request(RecipeApi.fetchRecipeList)
            .validateResponseWrapper(fromType: [Recipe].self,
                                     completion: completion,
                                     errorCompletion: errorCompletion)
    
    }
}
