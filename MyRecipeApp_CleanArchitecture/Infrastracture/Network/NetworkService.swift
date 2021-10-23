//
//  NetworkService.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

// TODO:- Dummy Network
protocol NetworkProviding {
    func requestData()
}

struct NetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `NetworkProvider`")
    }
}

struct MockedNetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `MockedNetworkProvider`")
    }
}
