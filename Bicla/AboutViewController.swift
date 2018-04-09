//
//  AboutViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/6/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet weak var circularImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
        
        circularImage.layer.cornerRadius = 50.0
        
        circularImage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
