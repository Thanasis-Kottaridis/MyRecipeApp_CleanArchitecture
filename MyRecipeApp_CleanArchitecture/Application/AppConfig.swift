//
//  AppConfig.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation

final class AppConfig {
    
    lazy var apiBaseURL: String = {
        let apiBaseURL = "https://vivawallet.free.beeceptor.com/v1/api"
        return apiBaseURL
    }()
    
    // TODO:- Check if this will be used.
    lazy var imagesBaseURL: String = {
        let imageBaseURL = "http://fakeimg.pl"
        return imageBaseURL
    }()
    
    lazy var apiRecipeBaseURL: String = {
        let apiBaseURL = "https://food2fork.ca/api/recipe"
        return apiBaseURL
    }()
    
    // TODO:- Check if this will be used.
    lazy var apiRecipeToken: String = {
        let apiRecipeToken = "9c8b06d329136da358c2d00e76946b0111ce2c48"
        return apiRecipeToken
    }()
}
