//
//  RecipeUrl.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

class RecipeUrl {
    private let appID = "c436f2d8"
    private let appKey = "5e3209a48597395659169c8113385b83"
    private var searchRecipe: String
   
    var baseUrl: String{
        return "https://api.edamam.com/api/recipes/v2?type=public&q=\(searchRecipe)&app_id=\(appID)&app_key=\(appKey)"
    }
    
    init(recipe: String) {
        self.searchRecipe = recipe
    }
}
