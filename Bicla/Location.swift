//
//  Location.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/12/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation


struct Location {
    let idLocation: Int?
    let latlon: [Double]?
    let title: String?
    let event_eventid_id: Int?

    
    init(dictionary: [String:AnyObject]) {
        idLocation = dictionary[Constants.LocationKeys.IdLocation] as? Int
        title = dictionary[Constants.LocationKeys.Title] as? String
        latlon = dictionary[Constants.LocationKeys.Latlot] as? [Double]
        event_eventid_id = dictionary[Constants.LocationKeys.Event_startid_id] as? Int
      
        
        
    }
    
    static func LocationFromResult(result: [String:AnyObject]) -> Location {
        return Location(dictionary: result)
    }
    
    static func LocationFromResults(results: [[String:AnyObject]]) -> [Location] {
        
        var location = [Location]()
        
        // iterate through array of dictionaries, each Restaurant is a dictionary
        for result in results {
            location.append(Location(dictionary: result))
        }
        
        return location
    }
}
