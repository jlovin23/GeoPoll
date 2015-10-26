//
//  GroupMemberSelection.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 10/7/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class GroupMemberSelection: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var friends: Array<PFUser> = []
    var selected: Array<PFUser> = []
    var groupName: String!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
        userData.fetchIfNeeded()
        
        friends = userData["friends"] as! Array<PFUser>
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return selected.count
        }
        else
        {
            return friends.count
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell: UITableViewCell = UITableViewCell()
            selected[indexPath.row].fetchIfNeeded()
            cell.textLabel?.text = selected[indexPath.row].username
            cell.backgroundColor = OurColors.easterGreen
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            friends[indexPath.row].fetchIfNeeded()
            cell.textLabel!.text = friends[indexPath.row].username
            
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = .Checkmark
        
        if indexPath.section == 0
        {
            for cell in tableView.visibleCells
            {
                if cell.textLabel?.text == selectedCell?.textLabel?.text && cell != selectedCell
                {
                    cell.userInteractionEnabled = true
                    cell.accessoryType = .None
                }
            }
            selected.removeAtIndex(indexPath.row)
        }
        else if indexPath.section == 1
        {
            selected.append(friends[indexPath.row])
            selectedCell?.userInteractionEnabled = false
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = .None
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Added"
        }
        else
        {
            return "Friends"
        }
    }
    
    @IBAction func saveGroup(sender: UIButton)
    {
        
        let currentUser = PFUser.currentUser()!
        
        let currentUserData: PFObject = currentUser.objectForKey("userData") as! PFObject
        currentUserData.fetchIfNeeded()
        
        var myGroups: Array<PFObject> = currentUserData["groups"] as! Array<PFObject>
        
        
        
        let group: PFObject = PFObject(className: "Group")
        group["members"] = selected
        group["questions"] = [PFObject]()
        group["creator"] = PFUser.currentUser()!
        group["name"] = groupName
        
        for user in self.selected
        {
            let userData: PFObject = user["userData"] as! PFObject
            userData.fetchIfNeeded()
            var groups: Array<PFObject> = userData["groups"] as! Array<PFObject>
            groups.append(group)
            userData["groups"] = groups
            userData.saveInBackground()
        }
        selected.append(PFUser.currentUser()!)
        
        myGroups.append(group)
        currentUserData.saveInBackground()

        
        group.saveInBackgroundWithBlock { (success, error) -> Void in
            if success
            {
                
                print("group saved")
            }
            else
            {
                print("group not saved")
            }
        }
    }
    
}