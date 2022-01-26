//
//  RecipeTableViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView! {
        didSet {
            recipeImage.layer.borderWidth = 1
            recipeImage.layer.masksToBounds = false
            recipeImage.layer.borderColor = UIColor.black.cgColor
            recipeImage.layer.cornerRadius = recipeImage.frame.size.width / 2
            recipeImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeHealth: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    
 
    func configureCell(with recipe: Recipe) {
        if let url = URL(string: recipe.image){
            recipeImage.sd_setImage(with: url)
        }else{
            recipeImage.image = UIImage(named: "slowmo")
        }
        recipeTitle.text = "title: \(recipe.label)"
        recipeSource.text = "source: \(recipe.source)"
        let healthLabelsArray = recipe.healthLabels.map({ (string) -> String in
            return string
        }).joined(separator: ", ")
        recipeHealth.text = "recipe health:"
        healthLabels.text = healthLabelsArray
    }
}
