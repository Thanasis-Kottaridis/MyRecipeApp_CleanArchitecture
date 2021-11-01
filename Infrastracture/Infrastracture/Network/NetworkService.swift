//
//  NetworkService.swift
//  Infrastracture
//
//  Created by thanos kottaridis on 2/11/21.
//

import Foundation
import Alamofire

public struct NetworkProvider {
    
    public init() {}
    
    lazy public var manager: Session = {
        //1
        let configuration = URLSessionConfiguration.af.default
        //2
        configuration.timeoutIntervalForRequest = 30
        //3
        return Session(configuration: configuration)
    }()
    
    // TODO: - Add more implementation
}
