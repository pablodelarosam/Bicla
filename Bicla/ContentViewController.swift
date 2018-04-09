
//
//  ContentViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 2/20/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageCarousel: UIImageView!
     @IBOutlet var forwardButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
         
        // Do any additional setup after loading the view.
        print("Image ", imageFile)
        imageCarousel.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle("SIGIUIENTE", for: .normal)
        case 2: forwardButton.setTitle("INCIO", for: .normal)
        default: break
        }
        
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        switch index {
        case 0...1:
            let pageViewController = parent as! CarouselPageViewController
            pageViewController.forward(index: index)
            
        case 2:
            
          ///  let pageViewController = parent as! CarouselPageViewController
            
            //pageViewController.forward(index: 0)
           //  dismiss(animated: true, completion: nil)
           let next = self.storyboard?.instantiateViewController(withIdentifier: "navPag")
            self.present(next!, animated: true, completion: nil)
            
        default: break
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
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
