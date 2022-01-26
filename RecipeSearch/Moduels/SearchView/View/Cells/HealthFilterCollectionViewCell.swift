//
//  HealthFilterCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit

class HealthFilterCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    func configureCell(with filter: HealthFilters, selected: Bool) {
        filterTitleLabel.text = filter.rawValue
        filterTitleLabel.textColor = selected ? .white : .black
        self.backgroundColor = selected ? .blue : .lightGray
    }
}
