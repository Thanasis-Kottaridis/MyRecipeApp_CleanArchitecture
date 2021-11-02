//
//  RecipeListUseCase.swift
//  Domain
//
//  Created by thanos kottaridis on 2/11/21.
//

import Foundation

public protocol RecipeListUseCase {
        
    func execute(
        forceReload: Bool,
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
    
    func queryRecipes(
        query: String,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage)-> Void
    )
}

// TODO: - Add implementation for search recipes
public final class RecipeListUseCaseImpl: RecipeListUseCase {
    
    private var recipeRepository: RecipeRepository
    
    public init (recipeRepository: RecipeRepository) {
        self.recipeRepository = recipeRepository
    }
    
    public func execute(
        forceReload: Bool,
        cached: @escaping ([Recipe]) -> Void,
        completion: @escaping ([Recipe]) -> Void,
        errorCompletion: @escaping (FeedbackMessage) -> Void
    ) {
        recipeRepository.fetchRecipes(
            forceReload: forceReload,
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
    
    public func queryRecipes(
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
