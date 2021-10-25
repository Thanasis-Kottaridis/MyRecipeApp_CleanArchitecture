//
//  RecipeListUseCaseTest.swift
//  MyRecipeApp_CleanArchitectureTests
//
//  Created by thanos kottaridis on 26/10/21.
//

import XCTest
@testable import MyRecipeApp_CleanArchitecture

class RecipeListUseCaseTest: XCTestCase {

    ///# mock recipe response to use in test
    static let mockRecipeResponse: [Recipe] = [
    Recipe(id: 1, name: "recipe 1", price: "0.1$", thumbnail: "thumbnail/path/1", image: "image/path/1", description: "recipe 1 dec"),
    Recipe(id: 2, name: "recipe 2", price: "0.2$", thumbnail: "thumbnail/path/2", image: "image/path/2", description: "recipe 2 dec"),
    Recipe(id: 3, name: "recipe 3", price: "0.3$", thumbnail: "thumbnail/path/3", image: "image/path/3", description: "recipe 3 dec"),
    Recipe(id: 4, name: "recipe 4", price: "0.4$", thumbnail: "thumbnail/path/4", image: "image/path/4", description: "recipe 4 dec"),
    Recipe(id: 5, name: "recipe 5", price: "0.5$", thumbnail: "thumbnail/path/5", image: "image/path/5", description: "recipe 5 dec")
    ]
    
    
    
    enum MockRecipeRepositoryError: Error {
        case faildFetching
    }
    
    ///# mock recipe repository implementation
    struct MockRecipeRepositoryImpl: RecipeRepository {
        var successNetworkResult: [Recipe]?
        var successLocalResult: [Recipe]?
        var errorResult: MockRecipeRepositoryError?
        
        func fetchRecipes(forceReload: Bool, cached: @escaping ([Recipe]) -> Void, completion: @escaping ([Recipe]) -> Void, errorCompletion: @escaping (Error?) -> Void) {
            
            if let successResult = successNetworkResult {
                completion(successResult)
            } else if let successResult = successLocalResult, !forceReload {
                cached(successResult)
            } else {
                errorCompletion(errorResult)
            }
        }
        
        func queryRecipes(query: String, completion: @escaping ([Recipe]) -> Void, errorCompletion: @escaping (Error?) -> Void) {
            if let successResult = successLocalResult {
                completion(successResult.filter{ $0.name?.contains(query) ?? false})
            } else if let errorResult = errorResult {
                errorCompletion(errorResult)
            }
        }
    }
    
    
    
    override func setUpWithError() throws {
        // Set up mock repository to dependency injection
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
        ### Test case to fetch a successful network response
        **Use Case**
        - Creates a New mockRepository ready to provide success response
        - Injecting it in to InjectedValues with key recipeRepository
        - RecipeList use case performs a mock network request with flag forceReload enabled
        - Expecting results is to fetch success response from repository
     */
    func testSuccessFetchRecipes() {
        InjectedValues[\.recipeRepository] = MockRecipeRepositoryImpl(successNetworkResult: RecipeListUseCaseTest.mockRecipeResponse)
        var results: [Recipe] = []
        let useCase = RecipeListUseCaseImpl()
            
        useCase.execute(forceReload: true) { recipeList in
            results = []
        } completion: { recipeList in
            results = recipeList
        } errorCompletion: { error in
            results = []
        }

//        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(results.count == 5 && results[0].id ?? 0 == 1)
    }
    
    /**
        ### Test case to fetch a error network response
        **Use Case**
        - Creates a New mockRepository ready to provide error response
        - Injecting it in to InjectedValues with key recipeRepository
        - RecipeList use case performs a mock network request with flag forceReload enabled
        - Expecting results is to fetch error response from repository
     */
    func testFailFetchRecipes() {
        InjectedValues[\.recipeRepository] = MockRecipeRepositoryImpl(errorResult: MockRecipeRepositoryError.faildFetching)
        var errorResult: MockRecipeRepositoryError?
        let useCase = RecipeListUseCaseImpl()
            
        useCase.execute(forceReload: true) { recipeList in
            errorResult = nil
        } completion: { recipeList in
            errorResult = nil
        } errorCompletion: { error in
            errorResult = MockRecipeRepositoryError.faildFetching
        }

//        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(errorResult == MockRecipeRepositoryError.faildFetching)
    }
    
    /**
        ### Test case to fetch a successful cache response
        **Use Case**
        - Creates a New mockRepository ready to provide success cache response
        - Injecting it in to InjectedValues with key recipeRepository
        - RecipeList use case performs a mock cache request with flag forceReload enabled
        - Expecting results is to fetch success cache response from repository
     */
    func testSuccessFetchCacheRecipes() {
        InjectedValues[\.recipeRepository] = MockRecipeRepositoryImpl(successLocalResult: RecipeListUseCaseTest.mockRecipeResponse)
        var results: [Recipe] = []
        let useCase = RecipeListUseCaseImpl()
            
        useCase.execute(forceReload: false) { recipeList in
            results = recipeList
        } completion: { recipeList in
            results = []
        } errorCompletion: { error in
            results = []
        }

//        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(results.count == 5 && results[0].id ?? 0 == 1)
    }
    
    /**
        ### Test case to fetch a successful query response
        **Use Case**
        - Creates a New mockRepository ready to provide success cache recipe List
        - Injecting it in to InjectedValues with key recipeRepository
        - RecipeList use case performs a mock query request
        - Expecting results is to fetch success query response from repository
     */
    func testSuccessQueryRecipes() {
        InjectedValues[\.recipeRepository] = MockRecipeRepositoryImpl(successLocalResult: RecipeListUseCaseTest.mockRecipeResponse)
        var results: [Recipe] = []
        let useCase = RecipeListUseCaseImpl()
            
        useCase.queryRecipes(query: "recipe 3") { recipeList in
            results = recipeList
        } errorCompletion: { error in
            results = []
        }

//        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(results.count == 1 && results[0].id ?? 0 == 3 )
    }
    
    
    func testFailQueryRecipes() {
        func testErrorQueryRecipes() {
            InjectedValues[\.recipeRepository] = MockRecipeRepositoryImpl(errorResult: MockRecipeRepositoryError.faildFetching)
            var results: FeedbackMessage?
            let useCase = RecipeListUseCaseImpl()
                
            useCase.queryRecipes(query: "recipe 3") { recipeList in
                results = nil
            } errorCompletion: { error in
                results = error
            }

            XCTAssertTrue(results != nil && results?.type == .error)
        }
    }

}
