//
//  RecipeRepositoryImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire
import RxSwift

final class RecipeRepositoryImpl: RecipeRepository {
    
    @Injected(\.recipeStorageProvider)
    private var cache: RecipeStorage
    private let sessionManager: Session = InjectedValues[\.networkProvider].manager
    
    /// fetch recipe from server
    private func fetchRecipesFromServer(
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (Error?)-> Void) {
            
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
    
    func fetchRecipes(
        forceReload: Bool,
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (Error?)-> Void
    ) {
        
        // fetch from network if forceReload required
        if forceReload {
            self.fetchRecipesFromServer(completion: completion, errorCompletion: errorCompletion)
            return
        }
        
        cache.getAllRecipes {[weak self] result in
            if case let .success(recipeList) = result,
               !recipeList.isEmpty {
                cached(recipeList)
            } else {
                self?.fetchRecipesFromServer(completion: completion, errorCompletion: errorCompletion)
            }
        }
    }
    
    func queryRecipes(query: String, completion: @escaping ([Recipe]) -> Void, errorCompletion: @escaping (Error?) -> Void) {
        cache.queryRecipes(query: query) { result in
            switch result {
            case .success(let recipeList):
                completion(recipeList)
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    
}





