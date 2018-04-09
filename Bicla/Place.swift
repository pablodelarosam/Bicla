//
//  Places.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/11/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation

struct Place {
    let description: String?
    let idbranch: Int?
    let model: String?
    let name: String?
    let complete_address: String?
    let latlon : [Double]
    let photo: String?
    init(dictionary: [String:AnyObject]) {
        complete_address = dictionary[Constants.PlaceKeys.Complete_address] as? String
        idbranch = dictionary[Constants.PlaceKeys.IdBranch] as? Int
        model = dictionary[Constants.PlaceKeys.Model] as? String
        name = dictionary[Constants.PlaceKeys.Name] as? String
        photo = dictionary[Constants.PlaceKeys.Photo] as? String
        latlon = (dictionary[Constants.PlaceKeys.Latlon] as? [Double])!
        description = dictionary[Constants.PlaceKeys.Description] as? String
        
        
    }
    
    static func placeFromResult(result: [String:AnyObject]) -> Place {
        return Place(dictionary: result)
    }
    
    static func PlaceFromResults(results: [[String:AnyObject]]) -> [Place] {
        
        var place = [Place]()
        
        // iterate through array of dictionaries, each Restaurant is a dictionary
        for result in results {
            place.append(Place(dictionary: result))
        }
        
        return place
    }
    
    func showAnnotations() {
        
    }
    
    func openMapsForPlace() {
        
    }
    
    func goMaps() {
        
    }
}


