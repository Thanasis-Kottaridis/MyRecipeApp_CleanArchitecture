//
//  RecipeStorage.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import Domain

protocol RecipeStorage {
    func getAllRecipes(completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void)
    func queryRecipes(query:String, completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void)
    func save(response: [Recipe])
}
