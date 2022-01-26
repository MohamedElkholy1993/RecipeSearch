//
//  SearchHealthFilterView.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit

class SearchHealthFilterView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var healthFilterCollectionView : UICollectionView!

    //MARK:- Vars
    var healthFilterArray: [HealthFilters] = [.All, .LowSugar, .Keto, .Vegan]
    var arrSelectedFilters = [HealthFilters]()
    
    weak var filterDelegate: FilterSearchProtocol?
    
    func configueView(with delegate: FilterSearchProtocol?) {
        filterDelegate = delegate
        healthFilterCollectionView.dataSource = self
        healthFilterCollectionView.delegate = self
        healthFilterCollectionView.register(UINib(nibName: SearchViewCellIdentifierConstants.HealthFilterCollectionViewCell.rawValue, bundle: .main), forCellWithReuseIdentifier: SearchViewCellIdentifierConstants.HealthFilterCollectionViewCell.rawValue)
        healthFilterCollectionView.reloadData()
    }
}

extension SearchHealthFilterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilter = healthFilterArray[indexPath.item]
        updateSelectedFilters(with: selectedFilter)
        setSelectedFilters(with: selectedFilter)
        
        collectionView.reloadData()
    }
}

extension SearchHealthFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthFilterArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchViewCellIdentifierConstants.HealthFilterCollectionViewCell.rawValue, for: indexPath)
        (cell as? HealthFilterCollectionViewCell)?.configureCell(with: healthFilterArray[indexPath.row], selected: arrSelectedFilters.contains(healthFilterArray[indexPath.row]))

        return cell
    }
}

extension SearchHealthFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 150, height: 40)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

//MARK:- Helpers
extension SearchHealthFilterView {
    private func updateSelectedFilters(with selectedFilter: HealthFilters) {
        if selectedFilter == .All, arrSelectedFilters.contains(selectedFilter) {
            arrSelectedFilters = []
        } else if selectedFilter == .All, !arrSelectedFilters.contains(selectedFilter) {
            arrSelectedFilters = [.All]
        } else if arrSelectedFilters.contains(selectedFilter) {
            arrSelectedFilters = arrSelectedFilters.filter { $0 != selectedFilter && $0 != .All }
        } else {
            arrSelectedFilters = arrSelectedFilters.filter { $0 != .All }
            arrSelectedFilters.append(selectedFilter)
        }
    }
    
    private func setSelectedFilters(with selectedFilter: HealthFilters) {
        filterDelegate?.filterSearchRecipes(filters: arrSelectedFilters.flatMap({ $0.filter }))
    }
}
