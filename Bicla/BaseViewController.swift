//
//  BaseViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
    
        print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("Map")
            //self.openViewControllerBasedOnIdentifier("WalkthroughController")
            
            break
        case 1:
            print("Inicio de sesión\n", terminator: "")
            
          //  check()
            
            self.openViewControllerBasedOnIdentifier("Login")
            
            break
            
        case 2:
            print("Información\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("About")
            //self.openViewControllerBasedOnIdentifier("Road")
            
            break
            
        case 3:
            print("Rodadas\n", terminator: "")
              self.openViewControllerBasedOnIdentifier("Road")
            let id = "Biclamx"
          /*  if let url = URL(string: "fb-messenger://user-thread/\(id)") {
                
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
            }*/
            
            break
            
        case 4:
            print("Asistencia\n", terminator: "")
             self.openViewControllerBasedOnIdentifier("Parts")
           // self.openViewControllerBasedOnIdentifier("Logout")
            
            break
            
        case 5:
            print("News\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("News")
            // text to share
           /* let text = "Descubre las mejores rodadas de toda Puebla con Bicla, invita a tus amigos a descargar la app, https://play.google.com/store/apps/details?id=mx.com.bicla.biclaandroid"
            
            // set up activity view controller
            let objectsToShare: [AnyObject] = [ text as AnyObject ]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            
            self.present(activityViewController, animated: true, completion: nil)
            */
            break
            
        case 6:
            print("Ca\n", terminator: "")
            let text = "Descubre las mejores rodadas de toda Puebla con Bicla, invita a tus amigos a descargar la app, https://play.google.com/store/apps/details?id=mx.com.bicla.biclaandroid"
            
            // set up activity view controller
            let objectsToShare: [AnyObject] = [ text as AnyObject ]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            
            self.present(activityViewController, animated: true, completion: nil)
            
    
            
            break
            
        case 7:
            
            logouts()
            
            
        default:
            print("default\n", terminator: "")
        }
    }
    
    func logouts() {
        // Check if account has provider
        let sharedPref = UserDefaults.standard
        let provider = sharedPref.string(forKey: "provider")
        
        
        if (provider == "Facebook") {
            let loginManager: FBSDKLoginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        
        Constants.Logout()
       // let next = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
      let next = self.storyboard?.instantiateViewController(withIdentifier: "navMap") as? UINavigationController
        self.present(next!, animated: true, completion: nil)
        
    }
    
    func check(){
        if Constants.checkSession() {
            self.openViewControllerBasedOnIdentifier("Login")
            /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let newViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
             self.present(newViewController, animated: true, completion: nil)*/
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
     
    
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
            self.navigationController?.navigationBar.barTintColor = UIColor.black
        
    
        
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        customBarItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = customBarItem;
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
    
    }

    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        return defaultMenuImage;
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            }, completion:nil)
    }
}
