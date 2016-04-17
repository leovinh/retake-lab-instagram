//
//  PhotoViewController.swift
//  InstaPair
//
//  Created by The Vinh Duong on 3/30/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var mediaData: [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fetchData() {
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                      completionHandler: { (dataOrNil, response, error) in
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                                NSLog("response: \(responseDictionary)")
                                                                                self.mediaData = responseDictionary["data"] as? [NSDictionary]
                                                                                self.tableView.reloadData()
                                                                            }
                                                                        }
        });
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if let data = mediaData {
            return data.count
            
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        let photoUrl = mediaData![indexPath.row]["images"]!["standard_resolution"]!!["url"] as! String
        let avatarUrl = mediaData![indexPath.row]["user"]!["profile_picture"] as! String
        cell.avatarImg.setImageWithURL(NSURL(string: avatarUrl)!)
        cell.photoImg.setImageWithURL(NSURL(string: photoUrl)!)
        
        return cell
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        let urlString = mediaData![indexPath!.row]["images"]!["standard_resolution"]!!["url"] as! String
        vc.url = NSURL(string: urlString)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
    }
    }
