//
//  RecipeListVC.swift
//  MyRecipeApp_CleanArchitecture
//
//  Created by thanos kottaridis on 24/10/21.
//

import UIKit
import RxSwift
import RxCocoa

class RecipeListVC: UIViewController {
    
    private enum ConstIdentifiers {
        static let recipeListCell = "RecipeListCell"
    }
    
    // MARK: - VARS
    private(set) var viewModel: RecipeListViewModel
    /// # RxSwift vars
    private let disposeBug = DisposeBag()
    
    //MARK: - Outlets
    @IBOutlet weak var recipesTableView: UITableView!
    lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: RecipeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up view
        setUpHeader()
        setUpObservers()
        setUpTableView()
        configureRefreshControl()
        
        // populate data
        viewModel.onTriggeredEvent(event: .fetchRecipes)
    }
    
    private func setUpHeader() {
        // set up nav bar
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = NSLocalizedString("AppTitle", comment: "")
        navigationController?.navigationBar.backItem?.title = nil
        
        // set up search bar
        searchController.searchBar.placeholder = NSLocalizedString("SearchPlaceholder", comment: "")
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    private func setUpObservers() {
        // set up tableView binding observer
        viewModel.stateObserver
            .observe(on: MainScheduler.instance) /// observe on mainThread coz we update UI
            .map { newState -> [RecipeDto] in
                return newState.recipeList
            }
            .distinctUntilChanged()
            .bind(to: recipesTableView.rx.items(cellIdentifier: ConstIdentifiers.recipeListCell, cellType: RecipeListCell.self)) { (row, item, cell) in
                cell.setUpCell(recipe: item, delegate: self)
            }.disposed(by: disposeBug)
        
        // set up search bar observer
        /// #sos debounce for 0.5 seconds to avoid unnecessary request while typing
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(.microseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext:{ [weak self] query in
                self?.viewModel.onTriggeredEvent(event: .queryRecipes(query: query))
            }).disposed(by: disposeBug)
    }
    
    private func setUpTableView() {
        recipesTableView.register(UINib(nibName: ConstIdentifiers.recipeListCell, bundle: nil), forCellReuseIdentifier: ConstIdentifiers.recipeListCell)
        recipesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        recipesTableView.contentInsetAdjustmentBehavior = .never
        recipesTableView.insetsContentViewsToSafeArea = true
    }
    
    private func configureRefreshControl() {
        recipesTableView.refreshControl = UIRefreshControl()
        recipesTableView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        viewModel.onTriggeredEvent(event: .refreshRecipes)
        recipesTableView.refreshControl?.endRefreshing()
        // dismiss search if in progress
        searchController.isActive = false
    }
}

//MARK: - Recipe Cell Delegate
extension RecipeListVC: RecipeCellDelegate {
    func didTapRecipe(recipe: RecipeDto) {
        //TODO: - FIX DETAILS PAGE
        // show recipe details
//        viewModel.onTriggeredEvent(event: .goToDetails(recipe: recipe))
    }
}
