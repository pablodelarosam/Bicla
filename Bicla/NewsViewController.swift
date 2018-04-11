//
//  NewsViewController.swift
//  Bicla
//
//  Created by Gerardo de la Rosa on 4/10/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire

class NewsViewController: UITableViewController {

    var news:[News] = [News]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/news", method: .get,  encoding: URLEncoding.default)
            .responseJSON { response in

                if let json = response.result.value as? [String:AnyObject] {
                    print("JSON: \(json)") // serialized json response
                    if let resData = json["news"]  {
                        self.news = News.NewsFromResults(results: resData as! [[String:AnyObject]])
                        if self.news.count > 0 {
                            self.tableView.reloadData()
                        }
                    }

                }

        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsViewCell
        let n = news[indexPath.row]

        cell.title?.text = n.title
        cell.desc?.text = n.description
        // cell.imageRoad.image = UIImage(named: "img")

        return cell
    }

}
