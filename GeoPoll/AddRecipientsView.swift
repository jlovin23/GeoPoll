//
//  AddRecipientsView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/24/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class AddRecipientsView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var friends = [PFUser]()
    var groups = [PFObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        updateFriends()
    }
    
    func updateFriends()
    {
        if let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as? PFObject
        {
            userData.fetchIfNeeded()
            friends = userData["friends"] as! Array<PFUser>
            groups = userData["groups"] as! Array<PFObject>
        }
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
            //return groups.count
        }
        else
        {
            if friends.count > 0
            {
                return friends.count
            }
            else
            {
                return 1
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecipientCell
        
        if friends.count > 0
        {
            friends[indexPath.row].fetchIfNeeded()
            cell.nameLabel.text = friends[indexPath.row].username
        }
        else
        {
            cell.nameLabel.text = "Nah"
        }
        
        return cell
    }
    
    @IBAction func goBack(sender: UIButton)
    {
        
    }
    
    @IBAction func userChecked(sender: UIButton)
    {
        if sender.selected == false
        {
            let uncheckedImage = UIImage(named: "checkbox_checked")
            sender.setImage(uncheckedImage,forState: UIControlState.Normal)
            sender.selected = true
        }
        else
        {
            let checkedImage = UIImage(named: "Checkbox_unchecked")
            sender.setImage(checkedImage,forState: UIControlState.Normal)
            sender.selected = false
        }
    }

}
