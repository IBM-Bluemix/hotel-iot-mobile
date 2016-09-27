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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = Twitter.sharedInstance().sessionStore
        
//        let lastSession = store.session
        let sessions = store.existingUserSessions()
        
            let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                
                let account = session!.userName;
                
                self.appDelegate.username = account;
                
                print("signed in as \(account)");
                
                print(session)
                
                // check if this user has an account
                
                
                let target = "http://127.0.0.1:6024/login";
                
                let url:URL = URL(string: target)!
                let session = URLSession.shared
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
                
                let paramString = "username=" + account;
                
                request.httpBody = paramString.data(using: String.Encoding.utf8)
                
                let task = session.dataTask(with: request as URLRequest) {
                    
                    (data, response, error) in
                    
                    guard let data = data, let _:URLResponse = response  , error == nil else {
                        print("error")
                        print(response)
                        return
                    }
                    
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    
                    print(dataString)
                }
                
                task.resume()
                
                self.performSegue(withIdentifier: "navigation", sender: nil)                
                
            } else {
                print("error: \(error!.localizedDescription)");
            }
            
        })
        
        
        logInButton.center.x = self.view.center.x  // for horizontal
        
        customizeButton(button: logInButton)

            twitterView.addSubview(logInButton)
        
    }
    
    func customizeButton(button: UIButton!) {
        
        let color = UIColor(red:0.61, green:0.85, blue:0.85, alpha:1.0)
        
        button.setBackgroundImage(nil, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

