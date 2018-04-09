//
//  SupportViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/5/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire

class SupportViewController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    
    @IBOutlet weak var num: UITextField!
    @IBOutlet weak var descriptionIssue: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var pickDamage: String = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        num.delegate = self
        descriptionIssue.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["Cadena", "Pedales", "Rueda", "Pintura"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickDamage = pickerData[row]
      //  print("picked", picked)
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        num.resignFirstResponder()
        descriptionIssue.resignFirstResponder()
      
   
        
        return true
        
    }

    @IBAction func sendInfo(_ sender: Any) {
        
        let params = ["id_bicla": num.text!, "issue_type": pickDamage, "comments": descriptionIssue.text! ]
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/support", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
    
                print(response.request!)  // original URL request
                print(response.response!) // HTTP URL response
                print(response.data!)     // server data
                print(response.result)   // result of response serialization
                if let value = response.result.value  as? [String:AnyObject] {
                    let json = value["status"] as! Int
                    
                    self.pickDamage = ""
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
