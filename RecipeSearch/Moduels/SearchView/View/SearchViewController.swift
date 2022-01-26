//
//  SearchViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var healthFilterView: SearchHealthFilterView!
    @IBOutlet weak var recipesView: RecipesView!
    
    //MARK:- Vars
    var searchViewModel = SearchViewModel()
    
    static func getSearchViewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "SearchViewController", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController ?? UIViewController()
        viewController.title = "Recipe Search"
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.bindHitsToView = onSuccess
        searchViewModel.bindErrorToView = onFail
        searchView.configueView(with: self)
        healthFilterView.configueView(with: self)
        recipesView.configureView(with: self)
    }
}

extension SearchViewController: SearchViewProtocol {
    func send(searchWord: String) {
        startLoading()
        searchViewModel.setSearchWord(with: searchWord)
    }
}

extension SearchViewController: FilterSearchProtocol {
    func filterSearchRecipes(filters: [String]) {
        guard !searchViewModel.searchWord.isEmpty else {
            onFail(error: "No data to be filtered")
            return
        }
        startLoading()
        searchViewModel.fetchRecipeData(filters: filters)
    }
}

extension SearchViewController: RecipesViewProtocol {
    func reloadNextRecipePage() {
        startLoading()
        if let nextRecipePageUrl = searchViewModel.nextPageUrl {
            searchViewModel.fetchRecipeData(with: nextRecipePageUrl)
        }
    }
    
    func showDetailsFor(recipe: Recipe) {
        let recipeDetailsVC = RecipeDetailsViewController.getRecipeDetailsViewController()
        (recipeDetailsVC as? RecipeDetailsViewController)?.recipe = recipe
        self.navigationController?.pushViewController(recipeDetailsVC, animated: true)
    }
}

//MARK:- Helpers
extension SearchViewController {
    private func startLoading() {
        MBProgressHUD.showAdded(to: self.recipesView, animated: true)
    }
    
    private func finishLoading() {
        MBProgressHUD.hide(for: self.recipesView, animated: true)
    }
    
    private func onSuccess(resetScroll: Bool){
        finishLoading()
        recipesView.updateView(with: searchViewModel.hits, resetScroll: resetScroll)
    }
    
    private func onFail(error: String){
        finishLoading()
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
}
