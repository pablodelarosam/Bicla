//
//  MenuPageViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 2/26/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit



class MenuPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        tblMenuOptions.tableFooterView = UIView()
      //  check()
        // Do any additional setup after loading the view.
        updateArrayMenuOptions()
         tblMenuOptions.reloadData()
        if let nameUser = Constants.getUserName()  {
            print("Username", nameUser)
            
            userName.text! = nameUser
        } else {
            userName.text! = "Bicla"
        }
        
        userPhoto.image = UIImage(named: "logo")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //check()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        updateArrayMenuOptions()
         tblMenuOptions.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
        
          tblMenuOptions.reloadData()
    }
    func check(){
        if Constants.checkSession() {
            
            arrayMenuOptions.remove(at: 1)
            /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let newViewController = storyBoard.instantiateViewController(withIdentifier: "Login")
             self.present(newViewController, animated: true, completion: nil)*/
        }
    }
    
    func updateArrayMenuOptions(){
         arrayMenuOptions.append(["title":"Inicio", "icon":"ic_home"])
        arrayMenuOptions.append(["title":"Inicio de sesión", "icon":"ic_navigation"])
        arrayMenuOptions.append(["title":"¿Quienes somos?", "icon":"ic_help"])
        arrayMenuOptions.append(["title":"Rodadas", "icon":"ic_directions_bike"])
        arrayMenuOptions.append(["title":"Asistencia", "icon":"ic_build"])
        arrayMenuOptions.append(["title":"Compartir", "icon":"timeline"])
        arrayMenuOptions.append(["title":"Cerrar sesión", "icon":"exit"])
     
        
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
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
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
}
