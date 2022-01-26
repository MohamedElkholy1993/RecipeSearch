//
//  SearchViewModel.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

class SearchViewModel {

    var hits: [Hit] = [] {
        didSet {
            bindHitsToView()
        }
    }
    var nextPageUrl: String?
    var searchWord: String = ""
    var isLoading = false
    var bindHitsToView: () -> () = {}
    var bindErrorToView: (String) -> () = {_ in }
   
    func setSearchWord(with search: String) {
        self.searchWord = search
        hits = []
        fetchRecipeData()
    }
    
    func fetchRecipeData(filters: [String] = []) {
        hits = []
        let baseUrl = RecipeUrl(recipe: searchWord).baseUrl
        let filtersUrl = filters.map({ "&health=\($0)" }).joined(separator: "")
        let filteredUrl = baseUrl + filtersUrl
        fetchRecipeData(with: filteredUrl)
    }
    
    func fetchRecipeData(with url: String) {
        guard !isLoading else { return }
        isLoading = true
        NetworkManager.sharedInstance.getData(for: url) {[weak self] (hits,nextPageUrl,error) in
            guard let weakSelf = self else { return }
            weakSelf.isLoading = false
            if let unwrappedError = error{
                weakSelf.bindErrorToView(unwrappedError)
            } else if let unwrappedHits = hits {
                weakSelf.hits += unwrappedHits
                weakSelf.nextPageUrl = nextPageUrl
            }
        }
    }
}
