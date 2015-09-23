//
//  FriendRequestCell.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/22/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FriendRequestCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deny: UIButton!
    @IBOutlet weak var approve: UIButton!
    var index: Int!
    var requests: Array<PFUser>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        approve.setTitleColor(OurColors.ponderGreen, forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func acceptPressed(sender: UIButton)
    {
        let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
        userData.fetchIfNeeded()
        
        var friends: Array<PFUser> = userData["friends"] as! Array<PFUser>
        
        friends.append(requests.removeAtIndex(index))
        
        userData["requests"] = requests
        
        userData["friends"] = friends
        userData.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil
            {
                print("friends updated")
            }
            else
            {
                print("error when updating friends")
            }
        }
    }

}