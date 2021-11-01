//
//  RecipeEntity+Mapping.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import CoreData

extension RecipeDto {
    func toEntity(in context: NSManagedObjectContext) -> RecipeEntity {
        let entity: RecipeEntity = .init(context: context)
        entity.pk = Int32(pk)
        entity.title = title
        entity.rating = Int32(rating ?? 0)
        entity.featuredImage = featuredImage
        entity.publisher = publisher
        entity.sourceUrl = sourceUrl
        entity.longDateAdded = Int64(longDateAdded ?? 0)
        entity.longDateUpdated = Int64(longDateUpdated ?? 0)
        ingredients?.forEach({ title in
            let ingredient = IngredientsEntity()
            ingredient.title = title
            entity.addToIngredients(ingredient)
        })
        
        return entity
    }
}

extension RecipeSearchResponse {
    func toEntity(in context: NSManagedObjectContext) -> RecipesSearchResponseEntity {
        let entity: RecipesSearchResponseEntity = .init(context: context)
        entity.count = Int32(count)
        entity.next = next
        entity.previous = previous
        results?.forEach {
            entity.addToRecipe($0.toEntity(in: context))
        }
        
        return entity
    }
}

extension RecipeEntity {
    func toDTO() -> RecipeDto {
        return .init(
            pk: Int(pk),
            title: title,
            publisher: publisher,
            featuredImage: featuredImage,
            rating: Int(rating),
            sourceUrl: sourceUrl,
            ingredients: ingredients?.allObjects.map{($0 as! String)},
            longDateAdded: longDateAdded,
            longDateUpdated: longDateUpdated)
    }
}

extension RecipesSearchResponseEntity {
    func toDTO() -> RecipeSearchResponse {
        return .init(
            count: Int(count),
            results: recipe?.allObjects.map{($0 as! RecipeEntity).toDTO()},
            next: next,
            previous: previous)
    }
}


// MARK: - DEPRICATED IMPL
extension Recipe {
    func toEntity(in context: NSManagedObjectContext) -> RecipeListEntity {
        let entity: RecipeListEntity = .init(context: context)
        entity.id = Int32(id ?? 0)
        entity.name = name
        entity.price = price
        entity.image = image
        entity.thumbnail = thumbnail
        entity.recipe_description = description
        return entity
    }
}

extension RecipeListEntity {
    func toDto() -> Recipe{
        return .init(
            id: Int(id),
            name: name,
            price: price,
            thumbnail: thumbnail,
            image: image,
            description: recipe_description
        )
    }
}
