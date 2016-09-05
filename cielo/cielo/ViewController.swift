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
import Twitter

class ViewController: UIViewController {
    
    @IBOutlet var twitterView: UIView!
    
    
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = Twitter.sharedInstance().sessionStore
        
        let lastSession = store.session
        let sessions = store.existingUserSessions()
        
            let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session!.userName)");
                
                print(session)
                
                // check if this user has an account
                                
                let request = NSMutableURLRequest(URL: NSURL(string: "http://127.0.0.1:6024/login")!)
                request.HTTPMethod = "POST"
                let postString = "username=" + session!.userName
                request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
                    guard error == nil && data != nil else {                                                          // check for fundamental networking error
                        print("error=\(error)")
                        return
                    }
                    
                    if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
                    
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("responseString = \(responseString)")
                }
                task.resume()
                
                
                
                
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

