//
//  InjectModules.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 23/10/21.
//

import Foundation


private struct AppConfigKey: InjectionKey {
    static var currentValue: AppConfig = AppConfig()
}

/**
 We create a NetworkProviderKey class that is responsible for instantiating NetworkProvider Key
 and conforms Injection Key protocol
 */
private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProvider = NetworkProvider()
}

private struct RecipeRepositoryKey: InjectionKey {
    static var currentValue: RecipeRepository = RecipeRepositoryImpl()
}

private struct RecipeStorageProviderKey: InjectionKey {
    static var currentValue: RecipeStorage = CoreDataRecipeStorageImpl()
}

private struct RecipeListUseCaseKey: InjectionKey {
    static var currentValue: RecipeListUseCase = RecipeListUseCaseImpl()
}

/**
 For every Injected Value we have to create a computed property of its Provider in order to have access on getting and setting method
 **Self:** Here referring to the working Extension
 **Provider.self:** here provides Provider type (that conforms InjectionKey) to InjectedValues key subscript.
 */
extension InjectedValues {
    
    var appConfig: AppConfig {
        get { Self[AppConfigKey.self]}
        set { Self[AppConfigKey.self] = newValue }
    }
    
    var networkProvider: NetworkProvider {
        get { Self[NetworkProviderKey.self]}
        set { Self[NetworkProviderKey.self] = newValue }
    }
    
    var recipeRepository: RecipeRepository {
        get { Self[RecipeRepositoryKey.self]}
        set { Self[RecipeRepositoryKey.self] = newValue }
    }
    
    var recipeStorageProvider: RecipeStorage {
        get { Self[RecipeStorageProviderKey.self] }
        set { Self[RecipeStorageProviderKey.self] = newValue }
    }
    
    var recipeListUseCase: RecipeListUseCase {
        get { Self[RecipeListUseCaseKey.self] }
        set { Self[RecipeListUseCaseKey.self] = newValue }
    }
}
