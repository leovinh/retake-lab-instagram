//
//  PhotoDetailsViewController.swift
//  InstaPair
//
//  Created by The Vinh Duong on 4/17/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    
    @IBOutlet weak var photoView: UIImageView!
    var url:NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.setImageWithURL(url!)

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
