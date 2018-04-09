//
//  Event.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/12/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

//
//  Places.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/11/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation

struct Event {
    let duration: String?
    let title: String?
    let idEvent: Int?
    let event_start: String?
    let locations: [Location]?

    init(dictionary: [String:AnyObject]) {
        duration = dictionary[Constants.EventKeys.Duration] as? String
        title = dictionary[Constants.EventKeys.Title] as? String
        idEvent = dictionary[Constants.EventKeys.IdEvent] as? Int
        event_start = dictionary[Constants.EventKeys.Event_start] as? String
        locations = dictionary[Constants.EventKeys.Locations] as? [Location]
        
        
    }
    
    static func eventFromResult(result: [String:AnyObject]) -> Event {
        return Event(dictionary: result)
    }
    
    static func EventFromResults(results: [[String:AnyObject]]) -> [Event] {
        
        var event = [Event]()
        
        // iterate through array of dictionaries, each Restaurant is a dictionary
        for result in results {
            event.append(Event(dictionary: result))
        }
        
        return event
    }
    
    func showEvents() {
        
    }
    
    func selectEvent() {
        
    }
}

