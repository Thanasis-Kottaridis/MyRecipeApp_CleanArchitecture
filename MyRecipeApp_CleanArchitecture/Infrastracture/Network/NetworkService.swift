//
//  NetworkService.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation
import Alamofire

struct NetworkProvider {
    
    lazy var manager: Session = {
        //1
        let configuration = URLSessionConfiguration.af.default
        //2
        configuration.timeoutIntervalForRequest = 30
        //3
        return Session(configuration: configuration)
    }()
    
    // TODO: - Add more implementation
}
