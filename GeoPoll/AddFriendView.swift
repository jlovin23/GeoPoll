//
//  AddFriendView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/16/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class AddFriendView: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sendRequestButton: UIButton!
    @IBOutlet weak var successBlurView: UIVisualEffectView!
    @IBOutlet weak var successBlurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleFieldsAndButtons()
        successBlurLabel.alpha = 0
        successBlurView.alpha = 0
        successBlurView.layer.cornerRadius = 20.0
    }
    
    override func viewDidLayoutSubviews() {
        Material.createBottomBorderForTextfield(usernameField)
    }
    
    func styleFieldsAndButtons()
    {
        titleLabel.backgroundColor = OurColors.ponderBlue
        cancelButton.backgroundColor = OurColors.ponderBlue
        sendRequestButton.backgroundColor = OurColors.ponderBlue
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendRequestButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleLabel.textColor = UIColor.whiteColor()
    }
    
    @IBAction func sendRequest(sender: UIButton)
    {
        let query: PFQuery = PFUser.query()!
        query.whereKey("username", equalTo:usernameField.text!)
        query.getFirstObjectInBackgroundWithBlock { (user, error) -> Void in
            
            if error != nil
            {
                print(error)
            }
            else
            {
                let addedUser: PFUser = user as! PFUser
                let userData: PFObject = addedUser["userData"] as! PFObject
                let currentUserData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
                
                userData.fetchIfNeeded()
                currentUserData.fetchIfNeeded()
                
                var requests: Array<PFUser> = userData["requests"] as! Array<PFUser>
                requests.append(PFUser.currentUser()!)
                
                userData["requests"] = requests
                
                
                var pending: Array<PFUser> = currentUserData["pending"] as! Array<PFUser>
                pending.append(addedUser)
                
                currentUserData["pending"] = pending
                
                userData.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success
                    {
                        currentUserData.saveInBackground()
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.successBlurView.alpha = 1.0
                            self.successBlurLabel.alpha = 1.0
                        }, completion: { (success) -> Void in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        })
                    }
                    else
                    {
                        print(error)
                    }
                })
            }
        }
    }
}
