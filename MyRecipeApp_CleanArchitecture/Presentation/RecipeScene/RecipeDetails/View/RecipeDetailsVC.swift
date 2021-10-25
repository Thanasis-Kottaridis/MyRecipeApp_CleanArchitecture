//
//  RecipeDetailsVC.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 25/10/21.
//

import UIKit
import RxSwift
import RxCocoa

class RecipeDetailsVC: UIViewController {
    
    @Injected(\.photosProvider)
    private var photosProvider: PhotosService
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var recipeDescription: UILabel!

    // MARK: - VARS
    private(set) var viewModel: RecipeDetailsViewModel
    /// # RxSwift vars
    private let disposeBug = DisposeBag()
    
    init(viewModel: RecipeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setUpScrollView()
        setUpObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        scrollView.setContentOffset(CGPoint(x: 0, y: -(212)), animated: false)
    }
    
    private func setUpHeader() {
    }
    
    private func setUpScrollView() {
//        scrollView.contentInsetAdjustmentBehavior = .never
//        scrollView.contentInset = UIEdgeInsets(top: 212, left: 0, bottom: 0, right: 0)
//        scrollView.delegate = self
    }
    
    private func setUpObservers() {
        // subscribe to viewModel state changes
        viewModel.stateObserver
            .observe(on: MainScheduler.instance) /// observe on mainThread coz we update UI
            .subscribe(onNext: { [weak self] state in
                self?.navigationItem.title = state.selectedRecipe.name
                self?.recipeDescription.text = state.selectedRecipe.description
                // fetch thumbnail
                guard let imageId = state.selectedRecipe.image else { return }
                self?.photosProvider.fetchImage(for: imageId,
                                                completion: { image in
                    self?.headerImageView.image = image
                }, errorCompletion: { error in
                    debugPrint(error.localizedDescription)
                    self?.headerImageView.image = UIImage(named: "no_image_available")
                })
        }).disposed(by: disposeBug)
    }
}

extension RecipeDetailsVC: UIScrollViewDelegate {

}
