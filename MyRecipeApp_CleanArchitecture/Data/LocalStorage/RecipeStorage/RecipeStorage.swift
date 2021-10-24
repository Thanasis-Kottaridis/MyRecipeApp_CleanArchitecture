//
//  RecipeStorage.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
protocol RecipeStorage {
    func getResponse(completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void)
    func save(response: [Recipe])
}
