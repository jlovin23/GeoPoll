//
//  AccountPopupViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/21/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class AccountPopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seeFriendRequestsCicked(sender: UIButton)
    {
        performSegueWithIdentifier("showRequests", sender: self)
    }
    

}
