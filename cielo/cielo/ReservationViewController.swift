//
//  ReservationViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-08-21.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let limpet = UIColor(red:0.61, green:0.85, blue:0.85, alpha:1.0)
        
        let snorkel = UIColor(red:0.00, green:0.31, blue:0.51, alpha:1.0)
        
        let limpetLight = UIColor(red:0.88, green:0.96, blue:0.96, alpha:1.0)
        
        navigationController!.navigationBar.barTintColor = snorkel
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tabBarController!.tabBar.barTintColor = limpetLight
        
        tabBarController!.tabBar.tintColor = snorkel


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
