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
    
    @Injected(\.photosProvider)
    private var photosProvider: PhotosService
    
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
                
        // set up cell views
        titleLbl.text = recipe.name
        descriptionLbl.text = recipe.description
        contentView.addTapGestureRecognizer {
            delegate.didTapRecipe(recipe: recipe)
        }
        
        // set up thumbnail
        thumbnail.layer.cornerRadius = 8
        // fetch photo
        guard let thumbnailUrl = recipe.thumbnail
        else {
            self.thumbnail.image = UIImage(named: "no_image_available")
            return
        }
        
        photosProvider.fetchImage(for: thumbnailUrl)
        {[weak self] image in
            self?.thumbnail.image = image
        } errorCompletion: {[weak self] _ in
            self?.thumbnail.image = UIImage(named: "no_image_available")
        }


    }

}
