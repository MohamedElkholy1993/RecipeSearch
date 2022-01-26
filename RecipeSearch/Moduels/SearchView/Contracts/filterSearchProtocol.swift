//
//  filterSearchProtocol.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

protocol filterSearchProtocol: NSObject {
    func filterSearchRecipes(filters: [String])
}
