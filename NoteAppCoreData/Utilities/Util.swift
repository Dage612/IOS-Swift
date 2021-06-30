//
//  Util.swift
//  Rest API
//
//  Created by Olman Mora on 6/24/21.
//  Copyright © 2021 Niso. All rights reserved.
//

import Foundation

class Util{
    private static let rootImageUrl = "https://image.tmdb.org/t/p"
    static func getFullImageUrl(imageUrl: String, width: Int = 200) -> String{
        return "\(rootImageUrl)/w\(width)\(imageUrl)"
    }
    
    static func getEndpointUrl(url: String, additionalParams: Dictionary<String, String>?) -> String{
        var composedUrl = "https://api.themoviedb.org/3/\(url)?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
        
        if let params = additionalParams {
            let queryParams = params.map({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            
            composedUrl += "&" + queryParams
        }
        
        return composedUrl
    }
    
    static func getEndpointUrl(url: String) -> String{
        return getEndpointUrl(url: url, additionalParams: [String: String]())
    }
}
