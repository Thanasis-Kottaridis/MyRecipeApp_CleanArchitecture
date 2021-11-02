//
//  RecipeEntity+Mapping.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Foundation
import CoreData
import Domain

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
