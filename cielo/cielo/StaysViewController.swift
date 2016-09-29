//
//  TempTableViewController.swift
//  cielo
//
//  Created by Anton McConville on 2016-09-20.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit

class StaysViewController: UITableViewController {
    
    @IBOutlet weak var table: UITableView!
    
    let items = ["Barcelona - Hotel Gaudi", "Ottawa - Hotel Roja", "Verona - Hotel Adige"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let limpet = UIColor(red:0.61, green:0.85, blue:0.85, alpha:1.0)
        
        let snorkel = UIColor(red:0.00, green:0.31, blue:0.51, alpha:1.0)
        
        let limpetLight = UIColor(red:0.88, green:0.96, blue:0.96, alpha:1.0)
        
        navigationController!.navigationBar.barTintColor = snorkel
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tabBarController!.tabBar.barTintColor = limpetLight
        
        tabBarController!.tabBar.tintColor = snorkel
        
        
        let target = "http://127.0.0.1:6024/reservations?account=" + appDelegate.username;
        
        let url:URL = URL(string: target)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "account=" + appDelegate.username;
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
            guard let data = data, let _:URLResponse = response  , error == nil else {
                print("error")
                print(response)
                return
            }
            
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            
            let dictionary = self.convertStringToDictionary(text: dataString!)
            
            print(dataString)
            
            print(dictionary)
        }
        
        //        self.performSegue(withIdentifier: "beaconsegue", sender: nil)
        
        
        task.resume()

        
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "visitCell", for: indexPath)as! ReservationTableViewCell
        
        // cell.textLabel?.text = self.items[indexPath.row]
        
        
        
        cell.hotelLabel.text = self.items[indexPath.row]
        cell.hotelLabel.textColor = UIColor(white: 114/255, alpha: 1)
        // Configure the cell...
        
        return cell
    }
    
//     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//        
//        let row = indexPath.row
//    }
//    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: (NSIndexPath!)) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        
//        self.performSegueWithIdentifier("toDiagnostics", sender: self)
    }

    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        print("this is a test");
        
        

     }
 
    
}
