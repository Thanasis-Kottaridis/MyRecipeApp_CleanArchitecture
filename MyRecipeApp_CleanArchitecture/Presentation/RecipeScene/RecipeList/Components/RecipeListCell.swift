//
//  RecipeListCell.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import Infrastracture
import UIKit
import Domain

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
        
        if let image = photosProvider.getCachedImage(for: thumbnailUrl) {
            debugPrint("fetched from cache: \(thumbnailUrl)")
            self.thumbnail.image = image

        } else {
            photosProvider.fetchImage(for: thumbnailUrl)
            {[weak self] image in
                debugPrint("fetched from network: \(thumbnailUrl)")
                self?.thumbnail.image = image
                self?.photosProvider.cacheImage(image: image, for: thumbnailUrl)
            } errorCompletion: {[weak self] _ in
                self?.thumbnail.image = UIImage(named: "no_image_available")
            }
        }
    }
}
