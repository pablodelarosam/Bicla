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
import XLActionController

class MapViewController: BaseViewController, MKMapViewDelegate {
    
    var mainViewController : UIViewController!
    var places:[Place] = [Place]()
    
    var flag = true
    
    @IBOutlet weak var mapView: MKMapView!
    
    var perroCafeLocation = "Floral, Atzala, 72810 San Andrés Cholula, Pue."
    var locations = ["Floral, Atzala, 72810 San Andrés Cholula, Pue.", "Universidad de las Américas Puebla", "Calle 14 Pte. 112, San Miguel, San Juan Aquiahuac, 72760 Cholula, Pue."]
    
    var titles = ["Perro Café", "Universidad de las Américas Puebla", "El Rosarito"]
    
    var biclaLocation = "14 Ote 816 Loc 1 Cp.72810"
    
    var latitudes: [CLLocationDegrees] = []
    
    var longitudes: [CLLocationDegrees] = []
    
    var subtitles = ["Café", "Universidad", "Bar"]
    
    var images = ["pci", "udlap-img", "rosarito"]
    
    var counter = 0
    
    var companies = ["AAPL" : "Apple Inc", "GOOG" : "Google Inc", "AMZN" : "Amazon.com, Inc", "FB" : "Facebook Inc"]
    
    var descriptionsPlaces: [String:String] = [String: String]()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        UINavigationBar.appearance().tintColor = UIColor.white
        mapView.delegate = self
        self.mapView.delegate = self
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
                                    self.descriptionsPlaces[self.places[i].name!] = self.places[i].description
                                  //  annotation. = self.places[i].description
                                    
                                    
                                    
                                    
                                    
                                    
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
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // first ensure that it really is an EventAnnotation:
       // presentBottomSheet()
        print("dictionary", self.descriptionsPlaces)
        if let eventAnnotation = view.annotation as? MKAnnotation {
            //let theEvent = eventAnnotation.idEvent
            print("counter", counter)
            if(counter > 2){
                let actionSheet = TwitterActionController()
                actionSheet.backgroundView.tintColor = UIColor.black
                // set up a header title
               actionSheet.collectionView.visibleCells
                // self.presentBottomSheet()
                for (key, value) in descriptionsPlaces {
                    print("\(key) = \(value)")
                    if(eventAnnotation.title!! == key) {
                        actionSheet.headerData = "Info"
                        // Add some actions, note that the first parameter of `Action` initializer is `ActionData`.
                        
                        
                       
                        actionSheet.addAction(Action(ActionData(title: eventAnnotation.title!!, subtitle: value, image: UIImage(named: "store")!), style: .default, handler: { action in
                            //do something useful
                            print("ok")
                        }))
                         present(actionSheet, animated: true, completion: nil)
                    }
                }
                
             
            }
           counter = counter + 1
            // now do somthing with your event
        }
     //   print("selected", selectedAnnotation!.)
        let button = UIButton(frame: .zero)
        button.setTitle("Button", for: UIControlState.normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(presentBottomSheet), for: .touchUpInside)
        self.view.addSubview(button)
     
    }
    
    @objc func presentBottomSheet() {
      //  print("clicked")
        // Instantiate custom action sheet controller
        let actionSheet = TwitterActionController()
        actionSheet.backgroundView.tintColor = UIColor.black
        
        // set up a header title
        actionSheet.headerData = "Info"
        // Add some actions, note that the first parameter of `Action` initializer is `ActionData`.
      
        actionSheet.addAction(Action(ActionData(title: "Xmartlabs", subtitle: "@xmartlabs", image: UIImage(named: "store")!), style: .default, handler: { action in
           //do something useful
            print("ok")
        }))
        present(actionSheet, animated: true, completion: nil)
        
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
  

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// As first step we should extend the ActionController generic type
public class TwitterActionController: ActionController<TwitterCell, ActionData, TwitterActionControllerHeader, String, UICollectionReusableView, Void> {
    
    // override init in order to customize behavior and animations
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // customizing behavior and present/dismiss animations
        settings.behavior.hideOnScrollDown = false
        settings.animation.scale = nil
        settings.animation.present.duration = 0.6
        settings.animation.dismiss.duration = 0.5
        settings.animation.dismiss.options = .curveEaseIn
        settings.animation.dismiss.offset = 30
        
        // providing a specific collection view cell which will be used to display each action, height parameter expects a block that returns the cell height for a particular action.
        cellSpec = .nibFile(nibName: "TwitterCell", bundle: Bundle(for: TwitterCell.self), height: { _ in 160})
        // providing a specific view that will render each section header.
        
     //   sectionHeaderSpec?.height.(10.0)
    
        sectionHeaderSpec = .cellClass(height: { _ in 0 })
        // providing a specific view that will render the action sheet header. We calculate its height according the text that should be displayed.
        
    
        
        headerSpec = .cellClass(height: { [weak self] (headerData: String) in
            guard let me = self else { return 0 }
           
            return 0 + 0
        })
        
        // once we specify the views, we have to provide three blocks that will be used to set up these views.
        // block used to setup the header. Header view and the header are passed as block parameters
      onConfigureHeader = { [weak self] header, headerData in
            guard let me = self else { return }
            header.backgroundColor = UIColor.black
            header.tintColor = UIColor.black
        
          /*  header.accessibilityLabel.frame = CGRect(x: 0, y: 0, width: me.view.frame.size.width - 40, height: CGFloat.greatestFiniteMagnitude)
            header.label.text = headerData
            header.label.sizeToFit()
            header.label.center = CGPoint(x: header.frame.size.width  / 2, y: header.frame.size.height / 2)
 */
        }
        // block used to setup the section header
        onConfigureSectionHeader = { sectionHeader, sectionHeaderData in
            sectionHeader.backgroundColor = UIColor.black
            sectionHeader.tintColor = UIColor.black
            sectionHeaderData
        }
        // block used to setup the collection view cell
        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            cell.setup(action.data?.title, detail:action.data?.subtitle, image: action.data?.image)
            
            //action.data?.image?
            cell.separatorView?.isHidden = indexPath.item == self!.collectionView.numberOfItems(inSection: indexPath.section) - 3
            cell.alpha = action.enabled ? 1.0 : 0.5
            cell.contentView.backgroundColor = UIColor.black
            cell.actionTitleLabel?.textColor = UIColor.white
            cell.actionTitleLabel?.font = .systemFont(ofSize: 27.0)
            let maxSize = CGSize(width: 250, height: 500)
            let size = cell.actionDetailLabel?.sizeThatFits(maxSize)
            cell.actionDetailLabel?.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: size!)
            cell.actionDetailLabel?.sizeToFit()
            cell.actionDetailLabel?.numberOfLines = 5
            cell.actionTitleLabel?.adjustsFontSizeToFitWidth = true
            cell.actionDetailLabel?.adjustsFontSizeToFitWidth = true
            cell.actionDetailLabel?.textColor = UIColor.white
            
    
             cell.actionDetailLabel?.font = .systemFont(ofSize: 20.0)
         
            
        
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: 100.0, height: 100.0)
        }
    
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





