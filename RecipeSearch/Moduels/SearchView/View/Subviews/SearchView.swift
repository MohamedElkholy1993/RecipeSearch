//
//  SearchView.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class SearchView: UIView {

    //MARK:- Outlets
    @IBOutlet weak var recipeSearch : UISearchBar! {
        didSet {
            recipeSearch.delegate = self
            recipeSearch.keyboardType = .namePhonePad
        }
    }
    
    @IBOutlet weak var blurView : UIView!{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            blurView.addGestureRecognizer(tap)
        }
    }
    
    //MARK:- Vars
    weak var delegate: SearchViewProtocol?
    var searchHistoryView = DropDown()
    var searchHistory: [String] = [] {
        didSet{
            if searchHistory.count == 11 {
                searchHistory.removeLast()
            }
        }
    }
    var searchHistoryFiltered: [String] = []
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    var blurEffectView: UIVisualEffectView?
    
    func configueView(with delegate: SearchViewProtocol?) {
        self.delegate = delegate
        searchHistoryView.dataSource = searchHistory
        configureSearchHistoryView(with: recipeSearch)
        configureBlurView()
        searchHistoryView.selectionAction = { [weak self] (index: Int, item: String) in
            guard let weakSelf = self else{ return }
            weakSelf.recipeSearch.text = item
        }
    }
}

extension SearchView: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        updateSearchHistory()
        searchHistoryView.dataSource = searchHistory
        searchHistoryView.show()
        blurView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHistoryFiltered = searchText.isEmpty ? searchHistory : searchHistory.filter({
            $0.range(of: searchText, options: .caseInsensitive) != nil
        })
        searchHistoryView.dataSource = searchHistoryFiltered
        searchHistoryView.show()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recipeSearch.resignFirstResponder()
        if let unwrappedSearchText = searchBar.text, !unwrappedSearchText.isEmpty {
            saveNewSearch(with: unwrappedSearchText)
            let searchWord = unwrappedSearchText.components(separatedBy: .whitespacesAndNewlines).joined()
            delegate?.send(searchWord: searchWord)
        }
        searchBar.text = ""
        searchHistoryView.hide()
        blurView.isHidden = true
    }
}

//MARK:- Helpers
extension SearchView {
    private func updateSearchHistory() {
        LocalDataManager.sharedInstance.createUserDefault()
        searchHistory = LocalDataManager.sharedInstance.getHistoryFromUserDefault()
    }
    
    private func saveNewSearch(with searchText: String) {
        if !searchHistory.contains(searchText){
            searchHistory.insert(searchText, at: 0)
            LocalDataManager.sharedInstance.saveHistoryToUserDefault(searchHistory: searchHistory)
        }
    }
    
    private func configureSearchHistoryView(with searchBar: UISearchBar) {
        searchHistoryView.anchorView = searchBar
        searchHistoryView.bottomOffset = CGPoint(x: 0, y: searchHistoryView.anchorView?.plainView.bounds.height ?? 0)
        searchHistoryView.backgroundColor = .white
        searchHistoryView.direction = .bottom
        searchHistoryView.dataSource = searchHistory
        searchHistoryView.dismissMode = .automatic
        
    }
    
    private func configureBlurView() {
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        guard let unwrappedBlurEffectView = blurEffectView else { return }
        unwrappedBlurEffectView.frame = blurView.bounds
        unwrappedBlurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(unwrappedBlurEffectView)
        blurView.isHidden = true
    }
    
    @objc func dismiss(){
        recipeSearch.resignFirstResponder()
        recipeSearch.text = ""
        searchHistoryView.hide()
        blurView.isHidden = true
    }
}
