//
//  ViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-08-13.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

import Fabric
import TwitterKit

class ViewController: UIViewController {
    
    @IBOutlet var twitterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session!.userName)");
            } else {
                print("error: \(error!.localizedDescription)");
            }
            
        })
        
        logInButton.center.x = self.view.center.x  // for horizontal

        twitterView.addSubview(logInButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

