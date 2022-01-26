//
//  FilterSearchProtocol.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

protocol FilterSearchProtocol: NSObject {
    func filterSearchRecipes(filters: [String])
}
