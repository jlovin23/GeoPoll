// JUST ADDED THIS COMMENT

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
        // get current user and their UserData
        
        let currentUser: PFUser = PFUser.currentUser()!
        // add the existing user to the "selected" array so the group will be added to their groups
        
        selected.append(currentUser)
        
        // create group object and save the members, questions, creator, and name
        
        let group: PFObject = PFObject(className: "Group")
        group["members"] = selected
        group["questions"] = [PFObject]()
        group["creator"] = currentUser
        group["name"] = groupName
        
        
        for person in self.selected
        {
            let personUserData: PFObject = person["userData"] as! PFObject
            personUserData.fetchIfNeeded()
            var personsGroups = personUserData["groups"] as! [PFObject]
            personsGroups.append(group)
            personUserData["groups"] = personsGroups
            personUserData.save()
        }
        
        group.saveInBackground()
        
        
        // go through each user in the selected array, and add the group to their groups in their UserData
        
        
        
        
        
        
//        let currentUser: PFUser = PFUser.currentUser()!
//        
//        let currentUserData: PFObject = currentUser.objectForKey("userData") as! PFObject
//        currentUserData.fetchIfNeeded()
//        
//        selected.append(currentUser)
//        //--------------------------
//        
//        
//        let group: PFObject = PFObject(className: "Group")
//        group["members"] = selected
//        group["questions"] = [PFObject]()
//        group["creator"] = PFUser.currentUser()!
//        group["name"] = groupName
//        
//        print("before loop")
//        
//        
//        
//        
//        for eachUser in self.selected
//        {
//            print("loop")
//            let userData: PFObject = eachUser["userData"] as! PFObject
//            userData.fetchIfNeeded()
//            var groups: Array<PFObject> = userData["groups"] as! Array<PFObject>
//            groups.append(group)
//            userData["groups"] = groups
//            userData.saveInBackgroundWithBlock({ (success, error) -> Void in
//                if success
//                {
//                    print("userData saved")
//                }
//            })
//            print("added to users groups")
//            
//        }
//        print("after loop")
//        
//        group.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success
//            {
//                print("group saved")
//            }
//        }
    }
    
}