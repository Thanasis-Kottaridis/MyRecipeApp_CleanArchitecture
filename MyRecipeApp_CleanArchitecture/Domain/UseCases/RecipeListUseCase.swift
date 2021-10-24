//
//  SearchRecipeUseCase.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation

protocol RecipeListUseCase {
        
    func execute(
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
    
    func queryRecipes(
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
}

// TODO: - Add implementation for search recipes 
final class RecipeListUseCaseImpl: RecipeListUseCase {
    
    @Injected(\.recipeRepository)
    private var recipeRepository: RecipeRepository
    
    func execute(
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage) -> Void
    ) {
        recipeRepository.fetchRecipes(
            cached: cached,
            completion: completion,
            errorCompletion: { error in
                let feedbackMessage = FeedbackMessage(
                    message: error?.localizedDescription ?? "Something Went Wrong",
                    type: .error)
                errorCompletion(feedbackMessage)
            }
        )
    }
    
    func queryRecipes(
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage) -> Void
    ) {
        // TODO: - Implement query functionality
    }
    
}