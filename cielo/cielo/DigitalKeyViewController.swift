//
//  DigitalKeyViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-09-28.
//  Copyright © 2016 IBM. All rights reserved.
//


/*
 
 Your access credentials to Estimote Cloud API:
 App ID:
 cielo-6nv
 App Token:
 5256b7f1313e9a68138dc857567bbe82
 
 */

import UIKit

class DigitalKeyViewController: UIViewController, ESTBeaconManagerDelegate {
    
    @IBOutlet var templabel:UILabel!;
    @IBOutlet var lightlabel:UILabel!;
    
    let placesByBeacons = [
        "63334:5289": [
            "Heavenly Sandwiches": 5, // read as: it's 50 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            "Green & Green Salads": 150,
            "Mini Panini": 325
        ],
        "648:12": [
            "Heavenly Sandwiches": 250,
            "Green & Green Salads": 100,
            "Mini Panini": 20
        ],
        "17581:4351": [
            "Heavenly Sandwiches": 350,
            "Green & Green Salads": 500,
            "Mini Panini": 170
        ]
    ]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID,
        identifier: "ranged region")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.beaconManager.delegate = self
        // 4. We need to request this authorization for every beacon manager
        self.beaconManager.requestAlwaysAuthorization()
        
        
        self.title = "Digital key"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let target = "http://cielo.mybluemix.net/environment";
        
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
           
            if let temp = dictionary?["temp"] as? NSNumber
            {
                let temp_string = "\(temp)"
            
                DispatchQueue.main.async {
                    self.templabel.text = temp_string
                }
            }
            
            if let light = dictionary?["light"] as? NSNumber
            {
                let light_string = "\(light)"
                
                DispatchQueue.main.async {
                    self.lightlabel.text = light_string
                }
            }
        }
        
        task.resume()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.beaconManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeacons(in: self.beaconRegion)
    }
    
    func placesNearBeacon(beacon: CLBeacon) -> [String]? {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        if let places = self.placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sorted { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }
        return nil
    }
    
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon],
                       in region: CLBeaconRegion) {
        if let nearestBeacon = beacons.first, let places = placesNearBeacon(beacon: nearestBeacon) {
            // TODO: update the UI here
            print(nearestBeacon.proximity.rawValue) // TODO: remove after implementing the UI
            
            if( nearestBeacon.proximity.rawValue == 1 ){
                
                print( "bingo");
            }
            
        }
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
