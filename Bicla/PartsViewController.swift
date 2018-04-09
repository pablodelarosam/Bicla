//
//  PartsViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 4/8/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class PartsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    

    
    var types = ["Pedales", "Frenos", "Asiento", "Rueda","Volante", "Cadena"]
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

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
        
        cell.typw.text = types[indexPath.row]
        
        cell.check.layer.borderColor = UIColor.black.cgColor
        cell.check.layer.borderWidth = 2
        
        return cell
        
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

}

