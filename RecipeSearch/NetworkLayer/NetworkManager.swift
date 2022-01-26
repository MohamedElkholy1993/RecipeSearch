//
//  NetworkManager.swift
//  RecipeSearch
//
//  Created by Mohamed Elkholy on 26/01/2022.
//  Copyright © 2022 Mohamed_Elkholy. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    private init() {}
    
    func getData(for url: String, completion: @escaping (_ hits: [Hit]?, _ url: String?, _ error: String?) -> ()){
        print("URL: \(url)")
        AF.request(url).validate().responseDecodable(of: JsonBody.self) { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.value else { return }
                let hits = data.hits
                let nextPageUrl = data.links.next.href
                completion(hits,nextPageUrl,nil)
            case .failure(let error):
                print(error)
                completion(nil,nil,error.localizedDescription)
                
            }
        }
    }
    
}
