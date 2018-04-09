//
//  User.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/4/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import Foundation


struct User {
    let cash: Double?
    let date_birth: Date?
    let email: String?
    let gender: String?
    let iduser: CLong?
    let name: String?
    let password: String?
    let image: String?
    
    
    init(dictionary: [String:AnyObject]) {
        cash = dictionary[Constants.UserKeys.Cash] as? Double
        date_birth = dictionary[Constants.UserKeys.DateBirth] as? Date
        email = dictionary[Constants.UserKeys.Email] as? String
        gender = dictionary[Constants.UserKeys.Gender] as? String
        iduser = dictionary[Constants.UserKeys.Iduser] as? CLong
        name = dictionary[Constants.UserKeys.Name] as? String
        password = dictionary[Constants.UserKeys.Password] as? String
        image = dictionary[Constants.UserKeys.Photo] as? String
        
    }
    
    static func userFromResult(result: [String:AnyObject]) -> User {
        return User(dictionary: result)
    }
    
    static func UserFromResults(results: [[String:AnyObject]]) -> [User] {
        
        var user = [User]()
        
        // iterate through array of dictionaries, each User is a dictionary
        for result in results {
            user.append(User(dictionary: result))
        }
        
        return user
    }
    
    
}
