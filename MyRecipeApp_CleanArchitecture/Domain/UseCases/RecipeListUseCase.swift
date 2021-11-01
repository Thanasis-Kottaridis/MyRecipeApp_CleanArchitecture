//
//  SearchRecipeUseCase.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

protocol RecipeListUseCase {
        
    func execute(
        page: Int,
        query: String,
        forceReload: Bool,
        cached: @escaping ([RecipeDto]) -> Void,
        completion: @escaping ([RecipeDto]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
    
    func queryRecipes(
        query: String,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
}

// TODO: - Add implementation for search recipes 
final class RecipeListUseCaseImpl: RecipeListUseCase {
    
    @Injected(\.recipeRepository)
    private var recipeRepository: RecipeRepository
    
    func execute(
        page: Int,
        query: String,
        forceReload: Bool,
        cached: @escaping ([RecipeDto]) -> Void,
        completion: @escaping ([RecipeDto]) -> Void,
        errorCompletion: @escaping (FeedbackMessage) -> Void
    ) {
        recipeRepository.fetchRecipes(
            page: page,
            query: query,
            forceReload: forceReload,
            cached: {response in cached(response.results)},
            completion: {response in completion(response.results)},
            errorCompletion: { error in
                let feedbackMessage = FeedbackMessage(
                    message: error?.localizedDescription ?? "Something Went Wrong",
                    type: .error)
                errorCompletion(feedbackMessage)
            }
        )
    }
    
    func queryRecipes(
        query: String,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage) -> Void
    ) {
        recipeRepository.queryRecipes(query: query,
                                      completion: completion) { error in
            let feedbackMessage = FeedbackMessage(
                message: error?.localizedDescription ?? "Something Went Wrong",
                type: .error)
            errorCompletion(feedbackMessage)
        }
        
    }
    
}
