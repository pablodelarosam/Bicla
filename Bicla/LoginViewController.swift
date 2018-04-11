//
//  LoginViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 2/6/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
 

    @IBOutlet weak var circularImage: UIImageView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var buttonFb: FBSDKLoginButton!
    var tokenStringFacebook: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.white
        let loginButton = FBSDKLoginButton()
        
        emailField.delegate = self
        password.delegate = self
        
       circularImage.layer.cornerRadius = 50.0
        
        circularImage.clipsToBounds = true
     
       // buttonFb.backgroundColor = UIColor.blue
      
        
      //  configureFacebook()
        // Add a custom login button to your app
    /*    let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
      //  myLoginButton.frame = CGRect(0, 0, 180, 40);
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
      //  myLoginButton.addTarget(self, action: self.loginButtonClicked(), for: .action, action: @selector(self.loginButtonClicked) forControlEvents: .TouchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)*/
    }
    override func viewDidAppear(_ animated: Bool) {
        check()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func check(){
        if Constants.checkSession() {
           /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
            self.present(newViewController, animated: true, completion: nil)*/
        }
    }
    
 
    
    @IBAction func loginFacebookAction(sender: AnyObject) {//action of the custom button in the storyboard
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.tokenStringFacebook = fbloginresult.token.tokenString!
                    print("fb entry", self.tokenStringFacebook)
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                
                if (error == nil){
                    //everything works print the user data
                 //   print("emailu", result!["email"] as? [String:AnyObject] )
                    let token = result!  as? [String:AnyObject]
                    let email = token!["email"]! as! String
                   // let img = token!["picture.type(large)"]! as! String
                    print("Tokenn", token)
                    var url = Constants.Api.BiclaHost
                    let parameter = ["signup_type": "social", "token": self.tokenStringFacebook]
                
                    Alamofire.request("http://ec2-54-86-142-141.compute-1.amazonaws.com/api/v0/user", method: .post , parameters: parameter, encoding:JSONEncoding.default)
                     .responseJSON { response in
                     //   print(response.request!)  // original URL request
                        if let status = response.response?.statusCode {
                            if(status == 200 ) {
                                
                                
                                print("Request succesful")
                                self.login(email: email, password: "biclamx")
                               /* let next = self.storyboard?.instantiateViewController(withIdentifier: "navPag") as! UINavigationController
                                self.present(next, animated: true, completion: nil)*/
                            } else {
                                let alert = UIAlertController(title: nil, message: "Problem with Faccebook, try later", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        }
                       
                  
                    }
             
                 
                } else {
                    let alert = UIAlertController(title: nil, message: "Problem with Faccebook, try later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    
 /*  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let token = result.token.tokenString
        print("Tokenizer", token!)
        
        if(token != nil) {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "navPage") as! UINavigationController
            self.present(next, animated: true, completion: nil)
        }else {
           let optionMenu = UIAlertController(title: nil, message: "Problem with Faccebook", preferredStyle: .alert)
            present(optionMenu, animated: true, completion: nil)
            
        }
        
    }*/
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
    }
    
/*    func configureFacebook()
    {
        buttonFb.readPermissions = ["public_profile", "email", "user_birthday"];
        buttonFb.delegate = self
    }*/
    
    @IBAction func openMessenger(_ sender: Any) {
            let id = "Biclamx" 
            if let url = URL(string: "fb-messenger://user-thread/\(id)") {
                
                // Attempt to open in Messenger App first
                UIApplication.shared.open(url, options: [:], completionHandler: {
                    (success) in
                    
                    if success == false {
                        // Messenger is not installed. Open in browser instead.
                        let url = URL(string: "https://m.me/\(id)")
                        if UIApplication.shared.canOpenURL(url!) {
                            UIApplication.shared.open(url!)
                        }
                    }
                })
            }
        
}
    
    @IBAction func loginNormal(_ sender: Any) {
        
        if (emailField.text!.isEmpty) {
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
            
        
        let params = ["email": emailField.text!, "password": password.text!]
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
                      // Constants.storeData(id: id, nombre: n, active:true, provider: "Facebook")
                        Constants.storeData(id: id, nombre: n, active: true, provider: "Facebook")
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailField.resignFirstResponder()
        password.resignFirstResponder()
        return true
        
    }

}
