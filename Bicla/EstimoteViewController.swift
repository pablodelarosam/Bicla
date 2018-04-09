//
//  EstimoteViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/4/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class EstimoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToApp(_ sender: Any) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "navMap") as? UINavigationController
        self.present(next!, animated: true, completion: nil)
        
        
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
