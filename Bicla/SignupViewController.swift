//
//  SignupViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 3/4/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.white
        nameField.delegate = self
        lastName.delegate = self
        password.delegate = self
        email.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        lastName.resignFirstResponder()
      
        return true
        
    }
    
    @IBAction func sign(_ sender: Any) {
        
        if (nameField.text!.isEmpty) {
            let alert = UIAlertController(title: nil, message: "No hay nombre", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (lastName.text!.isEmpty) {
            let alert = UIAlertController(title: nil, message: "No hay apellidos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if (email.text!.isEmpty) {
            let alert = UIAlertController(title: nil, message: "No hay correo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (password.text!.isEmpty) {
            let alert = UIAlertController(title: nil, message: "No hay contraseña", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            let params = ["signup_type": "no_social", "name": nameField.text! ,"email": email.text!, "password": password.text!]
            Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com" + "/api/v0/user", method: .post, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    
                    print(response.request!)  // original URL request
                    print(response.response!) // HTTP URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    
                    
                    if let status = response.response?.statusCode {
                        if(status == 200 ) {
                            
                            self.login(email: self.email.text!, password: self.password.text!)
                            
                        } else {
                            let alert = UIAlertController(title: nil, message: "Problem signing up, try later", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
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
    
    func login(email:String, password:String) {
        
         let params = ["email": email, "password": password]
        Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/login", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON { response in
                print("RESPONSE SIG", response.result.value)
            if let value = response.result.value  as? [String:AnyObject] {
                let json = value["status"] as! Int
                
                if (json == 200 ) {
                    let n = value["user"]!["name"] as! String
                    let id = value["user"]!["iduser"] as! Int
                    Constants.storeData(id: id, nombre: n, active:true, provider: "")
                     let next = self.storyboard?.instantiateViewController(withIdentifier: "navMap") as? UINavigationController
                    self.present(next!, animated: true, completion: nil)
                 //  let next = self.storyboard?.instantiateViewController(withIdentifier: "Home2") as! UINavigationController
                   // self.present(next, animated: true, completion: nil)
                } else  {
                    // Prepare Alert
                    let alert = UIAlertController(title: nil, message: "Usuario incorrecto", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
               
                }
                
                
            }
        }
    }
    }


