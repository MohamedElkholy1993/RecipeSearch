//
//  SearchViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: SearchView!
    
    static func getSearchViewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "SearchViewController", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController ?? UIViewController()
        viewController.title = "Recipe Search"
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        searchView.viewDidLoad()
    }
}

extension SearchViewController: SendSearchWordToViewControllerProtocol {
    func send(searchWord: String) {
        
    }
}

