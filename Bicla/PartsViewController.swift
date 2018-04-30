//
//  PartsViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/8/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire

class PartsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var númeroBicla: UITextField!
    let cell: AnyObject = "" as AnyObject
    
    @IBOutlet weak var descripcionBreve: UITextField!
    var value: String = String()
    
    var currentCell: String = String()
    
var unchecked = false
    
    var types = ["pedal2", "pedal", "asiento", "llanta","manubrio", "cadena"]

    var typest = ["Pedal", "Freno", "Asiento", "Llanta","Manubrio", "Cadena"]
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        númeroBicla.delegate = self
        descripcionBreve.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
        
        cell.typw.image = UIImage(named: types[indexPath.row] )
        
        cell.check.tag = indexPath.row
        cell.check.addTarget(self, action: #selector(check(_:)), for: UIControlEvents.touchUpInside)
        cell.check.layer.borderColor = UIColor.black.cgColor
        cell.check.layer.borderWidth = 2
        cell.namePart.text = typest[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
    
        
       // cell.check.setImage(UIImage(named:"check-box"), for: .normal)
        print("selected")
    }

    
    func dd(){
        
    }
    
    
    @objc func check(_ sender: UIButton) {
        let indexPaths : NSArray = self.collectionView!.indexPathsForSelectedItems! as NSArray
        print("fe", sender.tag)
       // let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
       // let cell = sendertwo as! UICollectionViewCell
        //let indexPath = self.collectionView!.indexPath(for: cell)
        
        
        if unchecked {
             sender.setImage(UIImage(named:"check-box-empty"), for: .normal)
            unchecked = false
           //  collectionView.reloadData()
        }
        else {
           sender.setImage(UIImage(named:"check-box"), for: .normal)
            value = value + " " + typest[sender.tag]
         //   print("t",typest[indexPath.row])
            print("value", value)
            unchecked = true
            
            // collectionView.reloadData()
        }

    
        
    }
    

    @IBAction func sendInfo(_ sender: Any) {
        
        let params = ["id_bicla": númeroBicla.text!, "issue_type": value, "comments": descripcionBreve.text! ]
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/support", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                print(response.request!)  // original URL request
                print(response.response!) // HTTP URL response
                print(response.data!)     // server data
                print(response.result)   // result of response serialization
                if let value = response.result.value  as? [String:AnyObject] {
                    let json = value["status"] as! Int
                    
                    self.value = ""
                    if (json == 200 ) {
                        
                        // Prepare Alert
                        let alert = UIAlertController(title: nil, message: "Información enviada", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else  {
                        // Prepare Alert
                        let alert = UIAlertController(title: nil, message: "Intente más tarde por favor", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                }
        }
        
        
    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
//
//        cell.typw.text = types[indexPath.row]
//
//
//
//        //print("Images", self.images)
//        //cell.backgroundColor = UIColor.red
//        //let url = URL(string: images[indexPath.row])
//        //cell.imageFlicker?.kf.setImage(with: url)
//        // Configure the cell
//
//        return cell
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        númeroBicla.resignFirstResponder()
        descripcionBreve.resignFirstResponder()
        return true
        
    }

}

