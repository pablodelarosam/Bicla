//
//  RoutesViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 2/6/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation

class RoutesViewController: UIViewController, MKMapViewDelegate  {

    @IBOutlet weak var mapView: MKMapView!
    
    var eventid: Int = Int()
    var routes:[Location] = [Location]()
    var latitudes:[String] = []
    var longitudes:[String] = []
    var names = ["3 sur"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        print("eventID", eventid)
        let parameters: Parameters = ["idEvent": self.eventid]
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/locations", method: .get,  parameters: parameters,  encoding: URLEncoding.default)
            .responseJSON { response in
                
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                print("Maps value", response.result)   // result of response serialization
                if let json = response.result.value as? [String:AnyObject] {
                    print("JSON: \(json)") // serialized json response
                    if let resData = json["locations"]  {
                        self.routes = Location.LocationFromResults(results: resData as! [[String:AnyObject]])
                        print("HAY ESTA CANTIDAD DE routas",self.routes.count)
                        
                        for i in 0..<self.routes.count {
                            //Convert address into coordenates
                           /* let geoCoder = CLGeocoder()
                            geoCoder.geocodeAddressString(self.routes[i].!, completionHandler: { placemarks, error in
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
                                        self.latitudes.append(location.coordinate.latitude)
                                        self.longitudes.append(location.coordinate.longitude)
                                        // Display the annotation
                                        self.mapView.showAnnotations([annotation], animated: true)
                                        self.mapView.selectAnnotation(annotation, animated: true)
                                        //   print(self.latitudes)
                                    }
                                }
                                
                            })*/
                            var route: Location!
                            route = self.routes[i]
                            let annotation = MKPointAnnotation()
                            
                            annotation.coordinate = CLLocationCoordinate2DMake( self.routes[i].latlon![0], self.routes[i].latlon![1])
                            annotation.title = self.routes[i].title
                      //      let dist:String = String(format:"%f", restaurant.distance!)
                            annotation.subtitle = self.routes[i].title
                            
                            
                            self.mapView.addAnnotation(annotation)
                            
                           // self.mapView.showAnnotations([annotation], animated: true)
                            //self.mapView.selectAnnotation(annotation, animated: true)
                        }
                     
                        //   self.filteredData = self.data
                        // self.filteredDataObj = self.stores
                    }
                    
                }
                
        }
        
        
   
        
    /*   for i in 0..<latitudes.count {
        
        let annotation = MKPointAnnotation()
        let decimalLat = Double(latitudes[i])
        let decimalLon = Double(longitudes[i])
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: decimalLat!, longitude: decimalLon!)
        annotation.title = names[i]
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        mapView.addAnnotation(annotation)
        
        }*/
        
       

        // Do any additional setup after loading the view.
    }
    
    
    
    //Function to change the image of the place
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        let mapButton = UIButton(frame: CGRect.init(x: 0, y: -30, width: 100, height: 50))
        mapButton.setTitle("Go to maps", for: .normal)
        mapButton.setTitleColor(.black, for: .normal)
        mapButton.titleLabel?.sizeToFit()
        //    mapButton.addTarget(self,  action: #selector(self.goMaps), for: .touchUpInside)
        //mapButton.backgroundColor = UIColor.red
        //  leftIconView.image = UIImage(named: images[0])
        //    annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
        
        
        
        
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if (control as? UIButton)?.buttonType == UIButtonType.detailDisclosure {
            mapView.deselectAnnotation(view.annotation, animated: false)
            // Get restaurant
            for i in 0..<self.routes.count {
                
                //var restaurant: Restaurant!
                // restaurant = self.restaurants[i]
                let lat = view.annotation?.coordinate.latitude
                let lon = view.annotation?.coordinate.longitude
                let title =  view.annotation?.title
               
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
