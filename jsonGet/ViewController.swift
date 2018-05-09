//
//  ViewController.swift
//  jsonGet
//
//  Created by rajendra reddy on 3/9/18.
//  Copyright © 2018 rajendra reddy. All rights reserved.
//

import UIKit

class
ViewController:UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableview: UITableView!
    var nameArray = [String]()
   // var name = [String]()
    var URLreq :URLRequest?
    var URLSes = URLSession(configuration: URLSessionConfiguration.default)
    var URLData :URLSessionDataTask?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        URLreq = URLRequest(url: URL(string:"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")!)
        URLreq?.httpMethod = "GET"
        URLData = URLSes.dataTask(with: URLreq!, completionHandler: { (data, response, error) in
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                let resultsArray = json["actors"] as! NSArray

                for i in 0..<resultsArray.count{
                    
                    let appDetails = resultsArray[i] as! NSDictionary
                    let name = appDetails.value(forKey: "name") as! String
                    print(appDetails["name"]!)
                    self.nameArray.append(name )
                }
            }
            catch{
                print("error")
            }
            
            DispatchQueue.main.async {
    self.tableview.reloadData()
            }
        })
           URLData?.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         tableView.separatorStyle = .none
         tableView.separatorColor = UIColor.red
        return nameArray.count

    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewCell
        cell.llb?.text = nameArray[indexPath.row]
       return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

