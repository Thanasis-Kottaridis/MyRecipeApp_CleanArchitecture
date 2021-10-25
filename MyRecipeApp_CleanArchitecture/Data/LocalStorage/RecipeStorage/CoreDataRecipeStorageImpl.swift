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
    
    private func deleteResponse(in context: NSManagedObjectContext) {
        let request = RecipeListEntity.fetchRequest()
        
        do {
            try context.fetch(request).forEach({ recipe in
                context.delete(recipe)
            })
        } catch {
            print(error)
        }
    }
    
    private func getResponse(
        fetchRequest: NSFetchRequest<RecipeListEntity>,
        completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void
    ) {
        coreDataManager.performBackgroundTask { context in
            do {
                var recipeList: [Recipe] = []
                try context.fetch(fetchRequest).forEach{
                    recipeList.append($0.toDto())
                }
                
                debugPrint("total recipes in storage: \(recipeList.count)")
                completion(.success(recipeList))
            } catch {
                debugPrint("fail to retrieve recipes from storage")
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
    
    
    func getAllRecipes(completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void) {
        getResponse(fetchRequest: fetchRequest(), completion: completion)
    }
    
    func queryRecipes(query: String,
                      completion: @escaping (Result<[Recipe], CoreDataStorageError>) -> Void) {
        let fetchRequest = self.fetchRequest()
        if !query.isEmpty{
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", query)
        }
        
        getResponse(fetchRequest: fetchRequest, completion: completion)
    }
    
    
}
