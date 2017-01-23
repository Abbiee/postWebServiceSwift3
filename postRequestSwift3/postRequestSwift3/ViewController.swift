//
//  ViewController.swift
//  postRequestSwift3
//
//  Created by PintLabs on 23/01/17.
//  Copyright © 2017 LostFrequencies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func postClickAction(_ sender: UIButton) {
        
        let dict = ["Email": "test@gmail.com", "Password":"123456"] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            
            
            let url = NSURL(string: "http://xxxxxxxxx.net/api/Login")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        let resultValue:String = parseJSON["success"] as! String;
                        print("result: \(resultValue)")
                        print(parseJSON)
                    }
                } catch let error as NSError {
                    print(error)
                }        
            }          
            task.resume()
        }
    }
}

