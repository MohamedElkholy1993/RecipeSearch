//
//  RecipeView.swift
//  RecipesView
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit

class RecipesView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyViewMessageLabel: UILabel!
    //MARK:- Vars
    var hits = [Hit]()
    weak var delegate: RecipesViewProtocol?
    
    func configureView(with delegate: RecipesViewProtocol) {
        self.delegate = delegate
        recipeTableView.dataSource = self
        recipeTableView.delegate = self
        recipeTableView.register(UINib(nibName: SearchViewCellIdentifierConstants.RecipeTableViewCell.rawValue, bundle: .main), forCellReuseIdentifier: SearchViewCellIdentifierConstants.RecipeTableViewCell.rawValue)
        emptyViewMessageLabel.text = "Use key words to start searching for recipes"
    }
    
    func updateView(with hits: [Hit], resetScroll: Bool) {
        self.hits = hits
        recipeTableView.isHidden = hits.isEmpty
        emptyView.isHidden = !hits.isEmpty
        recipeTableView.reloadData()
        
        if resetScroll {
            recipeTableView.performBatchUpdates(nil, completion: { [weak self] completed in
                guard let weakSelf = self, completed else { return }
                weakSelf.recipeTableView.setContentOffset(.zero, animated: false)
            })
        }
    }
    
    func showErrorMessage() {
        recipeTableView.isHidden = true
        emptyView.isHidden = false
        emptyViewMessageLabel.text = "No results found for your search"
    }
}


extension RecipesView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = hits[indexPath.row].recipe
        delegate?.showDetailsFor(recipe: recipe)
    }
    
}


extension RecipesView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath)
        let recipe = hits[indexPath.row].recipe
        (cell as? RecipeTableViewCell)?.configureCell(with: recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == hits.count {
            delegate?.reloadNextRecipePage()
        }
    }
}

