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
        page: Int,
        query: String,
        completion: @escaping (RecipeSearchResponse) -> Void,
        errorCompletion: @escaping (Error?)-> Void) {
            
            // extended completion to store data locally
            let _completion: ((RecipeSearchResponse) -> Void) = { recipeResponse in
                // cache response to local storage
                // TODO: - FIX Local caching
                //                self.cache.save(response: recipeList)
                
                
                // perform completion
                completion(recipeResponse)
            }
            
            let _ = self.sessionManager
                .request(RecipeApi.fetchRecipeList(page: page, query: query))
                .validateResponseWrapper(
                    fromType: RecipeSearchResponse.self,
                    completion: _completion,
                    errorCompletion: errorCompletion)
        }
    
    func fetchRecipes(
        page: Int,
        query: String,
        forceReload: Bool,
        cached: @escaping (RecipeSearchResponse) -> Void,
        completion: @escaping (RecipeSearchResponse) -> Void,
        errorCompletion: @escaping (Error?)-> Void
    ) {
        
        // fetch from network if forceReload required
        if forceReload {
            self.fetchRecipesFromServer(page: page,
                                        query: query,
                                        completion: completion,
                                        errorCompletion: errorCompletion)
            return
        }
        
        
        // TODO: - FIX Local caching
        //        cache.getAllRecipes {[weak self] result in
        //            if case let .success(recipeResponse) = result,
        //               !recipeResponse.isEmpty {
        //                cached(recipeList)
        //
        //            } else {
        //                self?.fetchRecipesFromServer(page: page,
        //                                             query: query,
        //                                             completion: completion,
        //                                             errorCompletion: errorCompletion)
        //            }
        //        }
        
        self.fetchRecipesFromServer(page: page,
                                    query: query,
                                    completion: completion,
                                    errorCompletion: errorCompletion)
        
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





