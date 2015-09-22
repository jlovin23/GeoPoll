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
    
    @IBAction func seeFriendRequestsCicked(sender: UIButton)
    {
        performSegueWithIdentifier("showRequests", sender: self)
    }
    
    @IBAction func dismissView(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
