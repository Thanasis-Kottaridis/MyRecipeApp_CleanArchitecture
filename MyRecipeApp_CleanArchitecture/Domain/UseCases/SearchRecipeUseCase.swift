//
//  SearchRecipeUseCase.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import  Alamofire

protocol SearchRecipeUseCase {
    func execute(
        query: String,
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (Error)-> Void
    )
}

// TODO: - Add implementation for search recipes 
