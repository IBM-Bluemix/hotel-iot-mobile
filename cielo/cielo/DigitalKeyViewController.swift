//
//  DigitalKeyViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-09-28.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

class DigitalKeyViewController: UIViewController {
    
    @IBOutlet var templabel:UILabel!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Digital key"
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        let target = "http://127.0.0.1:6024/temp";
        
        let url:URL = URL(string: target)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
            guard let data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                print(response)
                return
            }
            
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            
            let dictionary = self.convertStringToDictionary(text: dataString!)
            
            
//            let light = dictionary?["light"] as! String
            let temp = dictionary?["temp"]
            
            self.templabel.text = temp as! String
        }
        
        task.resume()
        

        // Do any additional setup after loading the view.
    }

    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
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
