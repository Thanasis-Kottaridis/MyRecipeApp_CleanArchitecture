//
//  RecipeRepositoryImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

final class RecipeRepositoryImpl: RecipeRepository {
    
    @Injected(\.recipeStorageProvider)
    private var cache: RecipeStorage
    private let sessionManager: Session = InjectedValues[\.networkProvider].manager
    
    
    func fetchRecipes(
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (Error?)-> Void
    ) {
        
        cache.getResponse {[weak self] result in
            
            if case let .success(recipeList) = result,
               !recipeList.isEmpty
            {
                cached(recipeList)
            } else {
            
                // fetch recipe from server
                guard let self = self else { return }
                
                // extended completion to store data locally
                let _completion: (([Recipe]) -> Void) = { recipeList in
                    // cache response to local storage
                    self.cache.save(response: recipeList)
                    // perform completion
                    completion(recipeList)
                }
                
                let _ = self.sessionManager.request(RecipeApi.fetchRecipeList)
                    .validateResponseWrapper(
                        fromType: [Recipe].self,
                        completion: _completion,
                        errorCompletion: errorCompletion)
            }
            
            
            
//            switch result {
//            case .success(let recipeList):
//                debugPrint("Data Retrieved from storage")
//                cached(recipeList)
//            case .failure(let error):
//                debugPrint("Fail to retrieve Recipe from storage: \(error.localizedDescription)")
//
        }
    }
}
