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
    var question: PFObject!
    
    @IBOutlet weak var table: UITableView!
    
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
            return groups.count
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
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            
            if groups.count > 0
            {
                groups[indexPath.row].fetchIfNeeded()
                cell.textLabel!.text = groups[indexPath.row].objectForKey("name") as! String
            }
            else
            {
                cell.textLabel!.text = "Nah"
            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            
            if friends.count > 0
            {
                friends[indexPath.row].fetchIfNeeded()
                cell.textLabel!.text = friends[indexPath.row].username
            }
            else
            {
                cell.textLabel!.text = "Nah"
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = .Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.accessoryType = .None
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Groups"
        }
        else
        {
            return "Friends"
        }
    }
    
    @IBAction func goBack(sender: UIButton)
    {
        
    }
    
    @IBAction func send(sender: UIButton)
    {
        question.saveInBackground()
        
        for var g = 0; g < groups.count; g++
        {
            if (tableView(table, cellForRowAtIndexPath: NSIndexPath(forRow: g, inSection: 0)) as! RecipientCell).selected
            {
                let selectedGroup: PFObject = groups[g]
                selectedGroup.fetchIfNeeded()
                var groupQuestions = selectedGroup["questions"] as! Array<PFObject>
                groupQuestions.append(question)
                selectedGroup["questions"] = groupQuestions
                selectedGroup.saveInBackground()
            }
        }
    }
}