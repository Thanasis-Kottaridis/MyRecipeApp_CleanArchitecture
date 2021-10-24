//
//  CoreDataRecipeStorageImpl.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import CoreData

class CoreDataRecipeStorageImpl: RecipeStorage {
    
    private let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    private func fetchRequest() -> NSFetchRequest<RecipeListEntity> {
        let request: NSFetchRequest = RecipeListEntity.fetchRequest()
        return request
    }
    
    func deleteResponse(in context: NSManagedObjectContext) {
        let request = RecipeListEntity.fetchRequest()

        do {
            try context.fetch(request).forEach({ recipe in
                context.delete(recipe)
            })
        } catch {
            print(error)
        }
    }
    
    func getResponse(completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void) {
        coreDataManager.performBackgroundTask { context in
            do {
                var recipeList: [Recipe] = []
                try context.fetch(self.fetchRequest()).forEach{
                    recipeList.append($0.toDto())
                }
                
                completion(.success(recipeList))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func save(response recipeList: [Recipe]) {
        coreDataManager.performBackgroundTask { context in
            do {
                // empty previous recipe List
                self.deleteResponse(in: context)
                
                // for each recipe convert it to RecipeEntity and insert it in current context
                recipeList.forEach {
                    context.insert($0.toEntity(in: context))
                }

                // save context in order to store changes.
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreData Recipe storage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    
}
