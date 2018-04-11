//
//  MapViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 1/21/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    var mainViewController : UIViewController!
    var places:[Place] = [Place]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var perroCafeLocation = "Floral, Atzala, 72810 San Andrés Cholula, Pue."
    var locations = ["Floral, Atzala, 72810 San Andrés Cholula, Pue.", "Universidad de las Américas Puebla", "Calle 14 Pte. 112, San Miguel, San Juan Aquiahuac, 72760 Cholula, Pue."]
    
    var titles = ["Perro Café", "Universidad de las Américas Puebla", "El Rosarito"]
    
    var biclaLocation = "14 Ote 816 Loc 1 Cp.72810"
    
    var latitudes: [CLLocationDegrees] = []
    
    var longitudes: [CLLocationDegrees] = []
    
    var subtitles = ["Café", "Universidad", "Bar"]
    
    var images = ["pci", "udlap-img", "rosarito"]
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        UINavigationBar.appearance().tintColor = UIColor.white
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
//        for place in locations {
//            print("Places", place)
//        }
        
        
//
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(biclaLocation, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = "Bicla"
                annotation.subtitle = "Empresa"
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
      
        
        
        
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/places", method: .get,  encoding: URLEncoding.default)
            .responseJSON { response in
                
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                print("Maps value", response.result)   // result of response serialization
                if let json = response.result.value as? [String:AnyObject] {
                    print("JSON: \(json)") // serialized json response
                    if let resData = json["branches"]  {
                        self.places = Place.PlaceFromResults(results: resData as! [[String:AnyObject]])
                        print("HAY ESTA CANTIDAD DE TIENDAS",self.places.count)
                        for i in 0..<self.places.count {
                            //Convert address into coordenates
                            let geoCoder = CLGeocoder()
                            geoCoder.geocodeAddressString(self.places[i].complete_address!, completionHandler: { placemarks, error in
                                if let error = error {
                                    print(error)
                                    return
                                }
                                
                                if let placemarks = placemarks {
                                    // Get the first placemark
                                    let placemark = placemarks[0]
                                    // let mapItem = MKMapItem(placemark: placemark as! MKPlacemark)
                                    
                                    
                                    // Add annotation
                                    let annotation = MKPointAnnotation()
                                    annotation.title = self.places[i].name
                                    annotation.subtitle = self.places[i].model
                                    
                                    
                                    
                                    
                                    
                                    
                                    if let location = placemark.location {
                                        annotation.coordinate = location.coordinate
                                        
                                        //    self.openMapForPlace(lat: location.coordinate.latitude, long: location.coordinate.longitude, placeName: self.titles[i])
                                     //   self.latitudes.append(location.coordinate.latitude)
                                      //  self.longitudes.append(location.coordinate.longitude)
                                        // Display the annotation
                                        self.mapView.showAnnotations([annotation], animated: true)
                                        self.mapView.selectAnnotation(annotation, animated: true)
                                        //   print(self.latitudes)
                                    }
                                }
                                
                            })
                        }
                     //   self.filteredData = self.data
                       // self.filteredDataObj = self.stores
                    }
           
                }

        }
        
        
     /*   for i in 0..<locations.count {
         //   print("Places", locations[i])
            
            //Convert address into coordenates
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(locations[i], completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]
                   // let mapItem = MKMapItem(placemark: placemark as! MKPlacemark)
                    
                    
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = self.titles[i]
                    annotation.subtitle = self.subtitles[i]
                    
                
                    
                    
                    
                    
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        
                    //    self.openMapForPlace(lat: location.coordinate.latitude, long: location.coordinate.longitude, placeName: self.titles[i])
                        self.latitudes.append(location.coordinate.latitude)
                        self.longitudes.append(location.coordinate.longitude)
                        // Display the annotation
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                     //   print(self.latitudes)
                    }
                }
                
            })
        }*/

        // Do any additional setup after loading the view.
        

   
    }
    
    
   
    
    
    //Function to change the image of the place
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        let secondPin = "Pin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
    
        
        // Reuse the annotation if possible
        var annotationView:MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        var bicla = "Bicla"
        if(annotation.title! == String(bicla)){
            print("true")
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "logo_white")
        } else {
            var annotationView:MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: secondPin)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: secondPin)
                annotationView?.canShowCallout = true
            }
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "ping")
          /*   var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            annotationView?.canShowCallout = true*/
            
            return annotationView
        
        }
       
       
        
    
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if (control as? UIButton)?.buttonType == UIButtonType.detailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            // Get restaurant
            for i in 0..<places.count {
                
                //var restaurant: Restaurant!
               // restaurant = self.restaurants[i]
                let lat = view.annotation?.coordinate.latitude
                let lon = view.annotation?.coordinate.longitude
                let title =  view.annotation?.title
                openMapForPlace(lat: lat!, long: lon!, placeName: title as! String )
             /*   if (restaurant.latitude == lat && restaurant.longitude == lon) {
                   // self.posRest = i
                    break
                }*/
            }
            
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
    @objc func goMaps() {
 for i in 0..<self.places.count {
    for j in 0..<self.places[i].latlon.count {
        openMapForPlace(lat: self.places[i].latlon[0], long: self.places[i].latlon[1], placeName: self.places[i].name!)

    }
        }
}
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
