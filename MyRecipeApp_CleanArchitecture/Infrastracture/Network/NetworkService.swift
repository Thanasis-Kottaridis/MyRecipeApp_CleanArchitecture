//
//  NetworkService.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

struct NetworkProvider {
    
    private var apiToken: String {
        return InjectedValues[\.appConfig].apiRecipeToken
    }
    
    lazy var manager: Session = {
        //1
        let configuration = URLSessionConfiguration.af.default
        // TODO: BAD PRACTICE SINCE NO USER AUTH NEEDED
        configuration.headers.add(HTTPHeader(name: "Authorization", value: "Token \(apiToken)"))
        //2
        configuration.timeoutIntervalForRequest = 30
        //3
        return Session(configuration: configuration)
    }()
    
    // TODO: - Add more implementation
}
