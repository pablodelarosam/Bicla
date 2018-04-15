//
//  New.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/14/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation

import Foundation

struct New {
    let description: String?
    let idNews: Int?
    let imagen: String?
    let title: String?
    //let locations: [Location]?
    
    init(dictionary: [String:AnyObject]) {
        description = dictionary[Constants.NewKeys.Description] as? String
        idNews = dictionary[Constants.NewKeys.iDnews] as? Int
        imagen = dictionary[Constants.NewKeys.Imagen] as? String
        title = dictionary[Constants.NewKeys.Title] as? String
        
        
    }
    
    static func newFromResult(result: [String:AnyObject]) -> New {
        return New(dictionary: result)
    }
    
    static func NewFromResults(results: [[String:AnyObject]]) -> [New] {
        
        var new = [New]()
        
        // iterate through array of dictionaries, each Restaurant is a dictionary
        for result in results {
            new.append(New(dictionary: result))
        }
        
        return new
    }
    
    func showEvents() {
        
    }
    
    func selectEvent() {
        
    }
}
