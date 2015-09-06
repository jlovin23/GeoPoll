//
//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse
// just added this comment
class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutPressed(sender: UIBarButtonItem) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
