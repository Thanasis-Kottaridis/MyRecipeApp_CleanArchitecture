//
//  RecipeListViewModelTest.swift
//  MyRecipeApp_CleanArchitectureTests
//
//  Created by thanos kottaridis on 26/10/21.
//

import XCTest
import RxBlocking
@testable import MyRecipeApp_CleanArchitecture


class RecipeListViewModelTest: XCTestCase {
    
    ///# mock recipe response to use in test
    static let mockRecipeResponse: [Recipe] = [
        Recipe(id: 1, name: "recipe 1", price: "0.1$", thumbnail: "thumbnail/path/1", image: "image/path/1", description: "recipe 1 dec"),
        Recipe(id: 2, name: "recipe 2", price: "0.2$", thumbnail: "thumbnail/path/2", image: "image/path/2", description: "recipe 2 dec"),
        Recipe(id: 3, name: "recipe 3", price: "0.3$", thumbnail: "thumbnail/path/3", image: "image/path/3", description: "recipe 3 dec"),
        Recipe(id: 4, name: "recipe 4", price: "0.4$", thumbnail: "thumbnail/path/4", image: "image/path/4", description: "recipe 4 dec"),
        Recipe(id: 5, name: "recipe 5", price: "0.5$", thumbnail: "thumbnail/path/5", image: "image/path/5", description: "recipe 5 dec")
    ]
    
    struct MockRecipeListUseCaseImpl: RecipeListUseCase {
        var expectation: XCTestExpectation?
        var error: FeedbackMessage?
        var recipeList: [Recipe] = []
        
        func execute(forceReload: Bool, cached: @escaping ([Recipe]) -> Void, completion: @escaping ([Recipe]) -> Void, errorCompletion: @escaping (FeedbackMessage) -> Void) {
            if let error = error {
                errorCompletion(error)
            } else if forceReload {
                completion(recipeList)
            } else {
                cached(recipeList)
            }
            
            expectation?.fulfill()
        }
        
        func queryRecipes(query: String, completion: @escaping ([Recipe]) -> Void, errorCompletion: @escaping (FeedbackMessage) -> Void) {
            if let error = error {
                errorCompletion(error)
            } else {
                completion(recipeList.filter{ $0.name?.contains(query) ?? false})
            }
            
            expectation?.fulfill()
        }
        
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /**
     ### Test case to fetch recipe List
     **Use Case**
     - Creates a New mockRecipeListUseCase to provide us a mock response
     - Injecting it in to InjectedValues with key recipeListUseCase
     - Creates a Recipe List view model by injecting recipeCoordinator
     - triggers .fetchRecipes event
     - observes state using RXSwift
     */
    func testViewModelFetchRecipesEvent() throws {
        let expectation = self.expectation(description: "contains only first page")
        InjectedValues[\.recipeListUseCase] = MockRecipeListUseCaseImpl(expectation: expectation, recipeList: RecipeListViewModelTest.mockRecipeResponse)
        
        let viewModel = RecipeListViewModel(recipeActionHandler: InjectedValues[\.recipeCoordinator])
        viewModel.onTriggeredEvent(event: .fetchRecipes)
        
        // observe state
        let state = try viewModel.stateObserver.toBlocking().first()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(state?.recipeList.count == 5 && state?.recipeList[0].id ?? 0 == 1 )
    }
    
    /// Same as previous test but this time we trigger refresh event
    func testViewModelRefreshRecipesEvent() throws {
        let expectation = self.expectation(description: "contains only first page")
        InjectedValues[\.recipeListUseCase] = MockRecipeListUseCaseImpl(expectation: expectation, recipeList: RecipeListViewModelTest.mockRecipeResponse)
        
        let viewModel = RecipeListViewModel(recipeActionHandler: InjectedValues[\.recipeCoordinator])
        viewModel.onTriggeredEvent(event: .refreshRecipes)
        
        // observe state
        let state = try viewModel.stateObserver.toBlocking().first()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(state?.recipeList.count == 5 && state?.recipeList[0].id ?? 0 == 1 )
    }
    
    
    /**
     ### Test case to query recipe List
     **Use Case**
     - Creates a New mockRecipeListUseCase to provide us a mock response
     - Injecting it in to InjectedValues with key recipeListUseCase
     - Creates a Recipe List view model by injecting recipeCoordinator
     - triggers .queryRecipe event with query
     - observes state using RXSwift
     */
    func testViewModelQueryRecipesEvent() throws {
        let expectation = self.expectation(description: "contains only first page")
        InjectedValues[\.recipeListUseCase] = MockRecipeListUseCaseImpl(expectation: expectation, recipeList: RecipeListViewModelTest.mockRecipeResponse)
        
        let viewModel = RecipeListViewModel(recipeActionHandler: InjectedValues[\.recipeCoordinator])
        viewModel.onTriggeredEvent(event: .queryRecipes(query: "recipe 3"))
        
        // observe state
        let state = try viewModel.stateObserver.toBlocking().first()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(state?.recipeList.count == 1 && state?.recipeList[0].id ?? 0 == 3 )
    }
}
