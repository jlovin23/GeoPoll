//
//  AccountPopupViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/21/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class AccountPopupViewController: UIViewController
{
    @IBOutlet weak var requestsImageButton: UIButton!
    @IBOutlet weak var logoutImage: UIButton!
    @IBOutlet weak var requestsText: UIButton!
    @IBOutlet weak var logoutText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidLayoutSubviews()
    {
        slidein(requestsImageButton)
        slidein(requestsText)
        slidein(logoutText)
        slidein(logoutImage)
    }
    
    @IBAction func seeFriendRequestsCicked(sender: UIButton)
    {
        performSegueWithIdentifier("showRequests", sender: self)
    }

    @IBAction func logout(sender: UIButton)
    {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil
            {
    
            }
        }
    }
    
    func slidein(button: UIButton)
    {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .CurveEaseIn, animations: { () -> Void in
            button.frame = CGRectMake(self.view.frame.size.width/2 - button.frame.size.width/2, button.frame.origin.y, button.frame.size.width, button.frame.size.height)
            }, completion: nil)
    }
}
