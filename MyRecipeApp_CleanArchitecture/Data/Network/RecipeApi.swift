//
//  RecipeApi.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

enum RecipeApi: URLRequestConvertible {
    
    /// Injecting Base URL Path
    var baseURLPath: String {
        return InjectedValues[\.appConfig].apiRecipeBaseURL
    }
    
    var apiToken: String {
        return InjectedValues[\.appConfig].apiRecipeToken
    }
    
    case fetchRecipeList(page: Int, query: String)
    
    var path: String {
        switch self {
        case .fetchRecipeList:
            return "/search"
        }
        // TODO: - ADD MORE PATHS HERE.
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchRecipeList:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchRecipeList:
            return URLEncoding.default
        }
    }
    
    // TODO: - Add implementation for headers here. Returns empty headers for now
    var headers: HTTPHeaders{
        
        switch self {
        case .fetchRecipeList:
            return [
                "Content-Type": "application/json",
                "Authorization" : "Token \(apiToken)"
            ]
            //        default:
            //            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
//        request.headers = headers
                
        //        request.allHTTPHeaderFields = headers
        
        // TODO: - Add implementation for params here. Returns empty headers for now
        var parameters: Parameters? = nil
        
        switch self {
        case .fetchRecipeList(let page, let query):
            parameters = [
                "page" : page,
                "query" : query
            ]
            //        default:
            //            parameters = nil
        }
        
//        AF.request("https://food2fork.ca/api/recipe/search",
//                   parameters: parameters,
//                   headers: HTTPHeaders(["Authorization":"Token 9c8b06d329136da358c2d00e76946b0111ce2c48"]))
//            .prettyPrintedJsonResponse().response{response in
//            debugPrint(response)
//        }
        
        // Log request
        print(request)
        
        return try encoding.encode(request, with: parameters)
    }
}
