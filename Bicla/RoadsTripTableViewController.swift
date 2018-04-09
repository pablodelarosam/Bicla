//
//  RoadsTripTableViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 1/21/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire

class RoadsTripTableViewController: UITableViewController {
    
    var events:[Event] = [Event]()
    var roads = ["road1", "road2", "road3"]
    var nameRoads = ["Rodada por Cholula", "Rodada hacia Angelópolis", "Rodada en pareja"]
    
    var descriptions: [String] = ["Diviertéte explorando los misterios de Cholula", "Conoce una de las mejores plazas comerciales de Puebla!", "Disfruta de una tarde romántica con tu pareja."]
    
    
    //Latitudes and longitudes 19.064516, -98.313589
    var latitudes = ["19.064516"]
    var longitudes = ["-98.313589"]
    
    var imgs = ["cholula", "ange", "pareja"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/events", method: .get,  encoding: URLEncoding.default)
            .responseJSON { response in
                
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                print("Maps value", response.result)   // result of response serialization
                if let json = response.result.value as? [String:AnyObject] {
                    print("JSON: \(json)") // serialized json response
                    if let resData = json["events"]  {
                        self.events = Event.EventFromResults(results: resData as! [[String:AnyObject]])
                        print("HAY ESTA CANTIDAD DE TIENDAS",self.events.count)
                        if self.events.count > 0 {
                             self.tableView.reloadData()
                        }
                        //   self.filteredData = self.data
                        // self.filteredDataObj = self.stores
                    }
                    
                }
                
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.events.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RoadsTableViewCell
        let event = events[indexPath.row]
        
        cell.nameRoad?.text = event.title
        cell.descriptionRoad?.text = event.event_start
        cell.date?.text = "20/02/2018"
        cell.imageRoad.image = UIImage(named: "cholula")
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "mapRoad", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "mapRoad"){
            let index = tableView.indexPathForSelectedRow?.row
            let nextController = segue.destination as! RoutesViewController
            let event = self.events[index!]
            nextController.eventid = event.idEvent!
           // nextController.longitudes = self.longitudes
            
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
