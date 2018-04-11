//
//  News.swift
//  Bicla
//
//  Created by Gerardo de la Rosa on 4/10/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation

struct News {
    let description: String?
    let idnews: Int?
    let title: String?
    let imagen: String?
    
    init(dictionary: [String:AnyObject]) {
        idnews = dictionary[Constants.NewsKeys.IdNews] as? Int
        title = dictionary[Constants.NewsKeys.Title] as? String
        description = dictionary[Constants.NewsKeys.Description] as? String
        imagen = dictionary[Constants.NewsKeys.Imagen] as? String
        
        
    }
    
    static func newsFromResult(result: [String:AnyObject]) -> News {
        return News(dictionary: result)
    }
    
    static func NewsFromResults(results: [[String:AnyObject]]) -> [News] {
        
        var news = [News]()
        
        // iterate through array of dictionaries, each Restaurant is a dictionary
        for result in results {
            news.append(News(dictionary: result))
        }
        
        return news
    }
    
}
