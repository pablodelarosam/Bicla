//
//  CarouselPageViewController.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 2/20/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit

class CarouselPageViewController:  PageBaseViewController, UIPageViewControllerDataSource {
    var mainViewController : UIViewController!
     var pageImages = ["paso1", "paso2", "paso3"]
    var pageHeadings = ["Learn faster", "Check emergencies", "Discover"]
    var pageContent = ["See short descriptions about families",
                       "Search for the most common apps",
                       "Discover the company"]
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.addSlideMenuButton()
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    
    func contentViewController(at index: Int) -> ContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? ContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
        
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
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
