//
//  LocalDataManager.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation

class LocalDataManager {
    static let sharedInstance = LocalDataManager()
    private let userDefault = UserDefaults.standard
    private init() {}
    
    func getHistoryFromUserDefault() -> [String] {
        return userDefault.object(forKey: SearchViewConstants.kHISTORY.rawValue) as? [String] ?? []
    }
    
    func saveHistoryToUserDefault(searchHistory: [String]){
        userDefault.set(searchHistory, forKey: SearchViewConstants.kHISTORY.rawValue)
    }
    
    func createUserDefault(){
        if !isKeyPresentInUserDefaults(key: SearchViewConstants.kHISTORY.rawValue) {
            saveHistoryToUserDefault(searchHistory: [])
        }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return userDefault.object(forKey: key) != nil
    }
    
}
