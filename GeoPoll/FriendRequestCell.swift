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
    
    func removeRequest (var pendingArray: Array<PFUser>) -> Array<PFUser>
    {
        print("remove method called")
        for var i = 0; i < pendingArray.count; i++
        {
            if pendingArray[i] == PFUser.currentUser()!
            {
                pendingArray.removeAtIndex(i)
            }
        }
        return pendingArray
    }
    
    @IBAction func acceptClicked(sender: UIButton)
    {
        print("cell method called")
        
        let currentUser = PFUser.currentUser()!
        let currentUserData: PFObject = currentUser["userData"] as! PFObject
        currentUserData.fetchIfNeeded()
        
        let requestingUser: PFUser = requests[index]
        let requestingUserData:PFObject = requestingUser["userData"] as! PFObject
        requestingUserData.fetchIfNeeded()
        
        
        var currentUserRequests: Array<PFUser> = requests
        var currentUserFriends: Array<PFUser> = currentUserData["friends"] as! Array<PFUser>
        
        currentUserFriends.append(currentUserRequests.removeAtIndex(index))
        
        currentUserData["friends"] = currentUserFriends
        currentUserData["requests"] = currentUserRequests
        
        currentUserData.saveInBackground()
        
        var requestingUserPending: Array<PFUser> = requestingUserData["pending"] as! Array<PFUser>
        var requestingUserFriends: Array<PFUser> = requestingUserData["friends"] as! Array<PFUser>
        
        print("Request: \(requestingUserPending[0])")
        print("Current: \(PFUser.currentUser()!)")
        
        for var i = 0; i < requestingUserPending.count; i++
        {
            if requestingUserPending[i] == PFUser.currentUser()! // I think it might be this
            {
                requestingUserPending.removeAtIndex(i)
            }
        }
        
        requestingUserFriends.append(PFUser.currentUser()!)
        
        requestingUserData["friends"] = requestingUserFriends
        requestingUserData["pending"] = requestingUserPending
        
        requestingUserData.saveInBackground()
    }

}