//
//  NewsViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/10/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class NewsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var news:[New] = [New]()
    
   @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        // Do any additional setup after loading the view.
        
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/news", method: .get,  encoding: URLEncoding.default)
            .responseJSON { response in
                
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                print("Maps value", response.result)   // result of response serialization
                if let json = response.result.value as? [String:AnyObject] {
                    print("JSON: \(json)") // serialized json response
                    if let resData = json["news"]  {
                        self.news = New.NewFromResults(results: resData as! [[String:AnyObject]])
                        print("HAY ESTA CANTIDAD DE noticias",self.news)
                        if self.news.count > 0 {
                            self.collectionView?.reloadData()
                        }
                        //   self.filteredData = self.data
                        // self.filteredDataObj = self.stores
                    }
                    
                }
                
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
      
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.news.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewsCollectionViewCell
        print(news[indexPath.row].imagen!)
       
        
      
        
        let url = URL(string: news[indexPath.row].imagen!)
        cell.imagen?.kf.setImage(with: url)
        cell.typeLabel.text = news[indexPath.row].title
        cell.contentView.backgroundColor = getRandomColor()
        
        
        
        cell.textn.text = news[indexPath.row].description
       /* cell.typw.image = UIImage(named: types[indexPath.row] )
        cell.check.addTarget(self, action: #selector(check(_:)), for: UIControlEvents.touchUpInside)
        cell.check.layer.borderColor = UIColor.black.cgColor
        cell.check.layer.borderWidth = 2*/
        
        return cell
        
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

func getRandomColor() -> UIColor{
    //Generate between 0 to 1
    let red:CGFloat = CGFloat(drand48())
    let green:CGFloat = CGFloat(drand48())
    let blue:CGFloat = CGFloat(drand48())
    
    return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
}
