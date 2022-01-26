//
//  RecipeDetailsViewController.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.erved.
//

import Foundation
import UIKit
import SDWebImage
import SafariServices

class RecipeDetailsViewController: UIViewController {

    //MARK:- vars
    var recipe: Recipe?
    
    //MARK:- Outlets
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var indredientsText: UITextView!
    
    static func getRecipeDetailsViewController() -> UIViewController {
        let storyBoard = UIStoryboard(name: "RecipeDetailsViewController", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController ?? UIViewController()
        viewController.title = "Recipe"
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRecipeDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareRecipeUrl))
        self.navigationItem.rightBarButtonItem = shareBar
    }
    
    //MARK:- Actions
    @IBAction func goToRecipeWebsite(_ sender: UIButton) {
        showRecipeWebsite()
    }
    
    @objc private func shareRecipeUrl() {
        let textToShare = "Share Recipe url"
        guard let unwrappedRecipe = recipe, let myWebsite = NSURL(string: unwrappedRecipe.url) else { return }
        let objectsToShare: [Any] = [textToShare, myWebsite]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}
    
//MARK:- Helpers
extension RecipeDetailsViewController {
    private func showRecipeDetails() {
        guard let unwrappedRecipe = recipe else { return }
        recipeTitleLabel.text = unwrappedRecipe.label
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.sizeToFit()
        
        recipeImageView.sd_setImage(with: URL(string: unwrappedRecipe.image))
        
        let ingredients = unwrappedRecipe.ingredientLines.joined(separator: "\u{0085}")
        indredientsText.text = ingredients
        indredientsText.sizeToFit()
    }
    
    private func showRecipeWebsite() {
        guard let unwrappedRecipe = recipe, let url = URL(string: unwrappedRecipe.url) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}
