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
                
                self.performSegueWithIdentifier("navigation", sender: nil)                
                
            } else {
                print("error: \(error!.localizedDescription)");
            }
            
        })
        
        logInButton.center.x = self.view.center.x  // for horizontal
        
        customizeButton(logInButton)

        twitterView.addSubview(logInButton)
    }
    
    func customizeButton(button: UIButton!) {
        
        let color = UIColor(red:0.61, green:0.85, blue:0.85, alpha:1.0)
        
        button.setBackgroundImage(nil, forState: .Normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = color.CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}

