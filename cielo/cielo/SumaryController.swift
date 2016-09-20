//
//  Summary.Swift
//  cielo
//
//  Created by Anton McConville on 2016-08-20.
//  Copyright © 2016 IBM. All rights reserved.
//

import Foundation

import Fabric
import TwitterKit

class SummaryController: UIViewController {
    
    @IBOutlet var twitterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let limpet = UIColor(red:0.61, green:0.85, blue:0.85, alpha:1.0)
        
        let snorkel = UIColor(red:0.00, green:0.31, blue:0.51, alpha:1.0)
        
        let limpetLight = UIColor(red:0.88, green:0.96, blue:0.96, alpha:1.0)
        
        navigationController!.navigationBar.barTintColor = snorkel
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tabBarController!.tabBar.barTintColor = limpetLight
        
        tabBarController!.tabBar.tintColor = snorkel

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
