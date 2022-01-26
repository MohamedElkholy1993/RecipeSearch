//
//  SearchViewConstants.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

enum SearchViewConstants: String {
    case kHISTORY = "searchHistory"
}

enum SearchViewCellIdentifierConstants: String {
    case HealthFilterCollectionViewCell
}

enum HealthFilters: String {
    case All
    case LowSugar = "Low Sugar"
    case Keto
    case Vegan
    
    var filter: [String] {
        switch self {
        case .All:
            return []
        case .LowSugar:
            return ["low-sugar"]
        case .Keto:
            return ["keto-friendly"]
        case .Vegan:
            return ["vegan"]
            
        }
    }
}
 
