// MAKING CHANGES ON SECONDARY COMP
//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {
    
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownActionButton: UIButton!
    
    var popupDrawerIsShowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-dropdownActionButton.frame.size.height, dropdownView.frame.size.width, dropdownView.frame.size.height)
    }
    
    @IBAction func logoutPressed(sender: UIBarButtonItem) {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    
    @IBAction func locationPressed(sender: UIButton) {
    }
    
    @IBAction func directPressed(sender: UIButton) {
    }
    

    @IBAction func addFriendPressed(sender: UIButton) {
    }
    
    @IBAction func dropdownActionButtonPressed(sender: UIButton)
    {
        if popupDrawerIsShowing {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-self.dropdownActionButton.frame.size.height, self.dropdownView.frame.size.width, self.dropdownView.frame.size.height)
            }, completion: nil)
            
            popupDrawerIsShowing = false
        } else {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-self.dropdownView.frame.size.height, self.dropdownView.frame.size.width, self.dropdownView.frame.size.height)
                }, completion: nil)
            popupDrawerIsShowing = true
        }
    }
}
