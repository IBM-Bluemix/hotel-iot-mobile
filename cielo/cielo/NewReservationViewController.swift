//
//  NewReservationViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-09-21.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

class NewReservationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet var checkin:UIDatePicker!;
    @IBOutlet var chekout:UIDatePicker!;
    @IBOutlet weak var hotel:UIPickerView!;
    
    var pickerData = ["Austin - Hotel Estrella","Barcelona - Hotel Gaudi","Buenos Aires - Hotel Azul","Ottawa - Hotel Rojo","Verona - Hotel Adige"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hotel.delegate = self
        hotel.dataSource = self
        
        let target = "http://127.0.0.1:6024/hotels";
        
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

            let hotels = ( dictionary?["hotels"] as! NSArray) as Array
            
            var names = [String]()
            var locations = [String]()
            
            for hotel in hotels{
                
                print(hotel["name"])
                
                let name = hotel["name"] as! String
                let location = hotel["location"] as! String
                
                names.append(name)
                locations.append(location)
            }
            
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        updateLabel()
    }
    
    func updateLabel(){
        let size = pickerData[hotel.selectedRow(inComponent: 0)]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
            let data = pickerData[row]
        
            let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightRegular)])
            label?.attributedText = title
            label?.textAlignment = .center
        return label!
        
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
