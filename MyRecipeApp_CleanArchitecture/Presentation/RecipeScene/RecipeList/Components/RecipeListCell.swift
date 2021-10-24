//
//  RecipeListCell.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import UIKit

protocol RecipeCellDelegate: AnyObject {
    func didTapRecipe(recipe: Recipe)
}

class RecipeListCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    private var recipe: Recipe?
    private weak var delegate: RecipeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setUpCell(recipe: Recipe, delegate: RecipeCellDelegate) {
        self.recipe = recipe
        self.delegate = delegate
        
        thumbnail.layer.cornerRadius = 8
        titleLbl.text = recipe.name
        descriptionLbl.text = recipe.description
        contentView.addTapGestureRecognizer {
            delegate.didTapRecipe(recipe: recipe)
        }
    }

}
