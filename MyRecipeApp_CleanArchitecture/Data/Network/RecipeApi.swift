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
        return InjectedValues[\.appConfig].apiBaseURL
    }
    
    case fetchRecipeList
    
    var path: String {
        switch self {
        case .fetchRecipeList:
            return "/recipes.json"
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
            return URLEncoding.queryString
        }
    }
    
    // TODO: - Add implementation for headers here. Returns empty headers for now
    var headers: [String: String] {
        return [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        // TODO: - Add implementation for params here. Returns empty headers for now
        let parameters: Parameters? = nil
        
        // Log request
        print(request)

        return try encoding.encode(request, with: parameters)
    }
    
}
