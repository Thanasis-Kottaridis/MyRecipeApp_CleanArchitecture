//
//  RecipeRepositoryImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

final class RecipeRepositoryImpl: RecipeRepository {
    
    //1
    let sessionManager: Session = {
        //2
        let configuration = URLSessionConfiguration.af.default
        //3
        configuration.timeoutIntervalForRequest = 30
        //4
        return Session(configuration: configuration)
    }()
    
    func fetchRecipes(
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (AFError)-> Void
    ) {
        
        sessionManager.request(RecipeApi.fetchRecipeList)
            .validate()
            .prettyPrintedJsonResponse()
            .responseDecodable { (response: DataResponse<[Recipe], AFError>) in
                switch response.result{
                case .success(let recipeList):
                    completion(recipeList)
                case .failure(let error):
                    guard let errorDescription = error.errorDescription
                    else {return}
                    debugPrint("Fetch recipe fail with error:")
                    debugPrint(errorDescription)
                    errorCompletion(error)
                }
            }
    
    }
}
