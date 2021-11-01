//
//  AppConfig.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

final class AppConfig {
    
    lazy var apiBaseURL: String = {
        let apiBaseURL = "https://thanasis-kottaridis.github.io/Data"
        return apiBaseURL
    }()
    
    // TODO:- Check if this will be used.
    lazy var imagesBaseURL: String = {
        let imageBaseURL = "http://fakeimg.pl"
        return imageBaseURL
    }()
}
