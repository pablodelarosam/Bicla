//
//  Constants.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/4/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//


import UIKit

// MARK: - Constants

struct Constants {

    // MARK: TMDB
    struct Api {
        static let ApiScheme = "http"
        static let ApiHost = "http://www.proppapp.com"
        static let BiclaHost = "http://ec2-54-86-142-141.compute-1.amazonaws.com"

        static let imagePath = "http://www.urbntaste.com/static/uploads"




    }
    struct PlaceKeys {

        static let IdBranch = "idbranch"
        static let Model = "model"
        static let Name = "name"
        static let Complete_address = "complete_address"
        static let Latlon = "latlon"
        static let Description = "description"
        static let Photo = "photo"
    }

    struct NewsKeys {

        static let IdNews = "idnews"
        static let Title = "title"
        static let Description = "description"
        static let Imagen = "imagen"
    }

    struct EventKeys {
        static let Duration = "duration"
        static let Title = "title"
        static let IdEvent = "idevent"
        static let Event_start = "event_start"
        static let Locations = "locations"

    }

    struct LocationKeys {
        static let IdLocation = "idlocation"
        static let Latlot = "latlon"
        static let Title = "title"
        static let Event_startid_id = "event_eventid_id"
        static let Locations = "locations"

    }

    struct PromoKeys {
        static let Codes = "codes"
        static let Counter = "counter"
        static let Description = "description"
        static let Idpromo = "idpromo"
        static let Name = "name"
        static let Photo = "photo"
        static let Limittime = "limit_time"
        static let Distance = "distance"
        static let BranchPromo = "branch"
        static let StoreName = "store_name"
        static let Schedule = "schedule"
    }

    struct UserKeys {
        static let Cash = "cash"
        static let DateBirth = "date_birth"
        static let Email = "email"
        static let Gender =  "gender"
        static let Iduser = "iduser"
        static let Name = "name"
        static let Password = "password"
        static let Photo = "photo"

    }


    static   func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)

        let contextSize: CGSize = contextImage.size

        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }


    static func storeData(id: Int, nombre: String, active:Bool , provider: String){
        let sharedInfo = UserDefaults.standard
        sharedInfo.setValue(id, forKey: "id")
        sharedInfo.setValue(nombre, forKey: "nombre")
        sharedInfo.setValue(active, forKey: "active")
        sharedInfo.setValue(provider, forKey: "provider")


    }

    static func storeFilter(filter: [String]) {
        let sharedInfo = UserDefaults.standard
        sharedInfo.setValue(filter, forKey: "filter")

    }

    static func Logout() {
        self.storeData(id: -1 , nombre: "", active: false, provider: "")
    }


    static func getUserSessionId() -> Int{
        let sharedPref = UserDefaults.standard
        let id = sharedPref.integer(forKey: "id")
        return id
    }

    static func getUserName() -> String{
        let sharedPref = UserDefaults.standard
        let id = sharedPref.string(forKey:"nombre" )
        return id!
    }

    static func getUserPhoto() -> String{
        let sharedPref = UserDefaults.standard
        let id = sharedPref.string(forKey:"nombre" )
        return id!
    }


    static func checkSession() -> Bool {
        let sharedPref = UserDefaults.standard
        let act = sharedPref.bool(forKey: "active")
        return act
    }

    static func getNewImagesFood(image: UIImage) ->UIImage {
        let collectionwidt:Double = Double(image.size.width)
        let collectionheight:Double = Double(image.size.height)
        //return imageByCroppingImage(image, size: CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height))
        return cropToBounds(image: image, width: collectionwidt, height: collectionheight)
    }


    static func getFilter() -> [String] {

        let sharedPref = UserDefaults.standard
        let filter = sharedPref.array(forKey: "filter")




        return filter as! [String]
    }

    static func checkTutorial() -> Bool {
        let sharedPref = UserDefaults.standard
        let tutorial = sharedPref.bool(forKey: "tutorial")


        return tutorial
    }

}
