//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var lblTitle : UILabel = UILabel()
    var imgIcon : UIImageView = UIImageView()
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    /**
    *  Array to display menu options
    */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // check()
        UINavigationBar.appearance().tintColor = UIColor.white
        tblMenuOptions.tableFooterView = UIView()
        if let nameUser = Constants.getUserName()  {
            print("Username", nameUser)
            
            userName.text! = nameUser
        } else {
            userName.text! = "Bicla"
        }
     
        userPhoto.image = UIImage(named: "logo_white")
        userPhoto.layer.cornerRadius = 25
        userPhoto.clipsToBounds = true 
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // check()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
        
        check()
    }
    
    func check(){
        if Constants.checkSession() {
            print(arrayMenuOptions)
         //  arrayMenuOptions.append(["title":"Cerrar sesión", "icon":"cerrar_sesion"])
                let indexPathg = NSIndexPath(row: 1, section: 0)
            
        
        //    tblMenuOptions.cellForRow(at: 1)?.isHidden = true
            /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let newViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
             self.present(newViewController, animated: true, completion: nil)*/
        } else {
             arrayMenuOptions.remove(at: 7)
        }
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Descubre", "icon":"descubre"])
        arrayMenuOptions.append(["title":"Inicio de sesión", "icon":"account"])
        arrayMenuOptions.append(["title":"¿Quiénes somos?", "icon":"informacion"])
        arrayMenuOptions.append(["title":"Trips", "icon":"estacionamientos"])
        arrayMenuOptions.append(["title":"Asistencia", "icon":"asistencia"])
         arrayMenuOptions.append(["title":"Noticias", "icon":"noticias"])
        arrayMenuOptions.append(["title":"Compartir", "icon":"timeline"])
        arrayMenuOptions.append(["title":"Cerrar sesión", "icon":"cerrar_sesion"])
        
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        lblTitle = cell.contentView.viewWithTag(101) as! UILabel
         imgIcon = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat{
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        if(indexPath.row == 1){
            if Constants.checkSession() {
                print(arrayMenuOptions)
                //  arrayMenuOptions.append(["title":"Cerrar sesión", "icon":"cerrar_sesion"])
                self.lblTitle.text = ""
                self.imgIcon.isHidden = true
                return 0
                /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let newViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
                 self.present(newViewController, animated: true, completion: nil)*/
            } else {
                
            }
        }
        
        
      
        
        return 50
        
    }
}
