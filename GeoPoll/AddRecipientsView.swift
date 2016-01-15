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
        print(question)
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
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        selectedCell?.backgroundColor = OurColors.ponderBlue
        question.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil
            {
                for var g = 0; g < self.groups.count; g++
                {
                    let indexPathThing = NSIndexPath(forRow: g, inSection: 0)
                    if self.table.cellForRowAtIndexPath(indexPathThing)?.selected == true
                    {
                        let selectedGroup: PFObject = self.groups[g]
                        selectedGroup.fetchIfNeeded()
                        var groupQuestions = selectedGroup["questions"] as! Array<PFObject>
                        groupQuestions.append(self.question)
                        selectedGroup["questions"] = groupQuestions
                        selectedGroup.saveInBackgroundWithBlock({ (aSuccess, anotherError) -> Void in
                            if anotherError == nil
                            {
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }
                        })
                    }
                }
            }
        }
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Groups"
    }
    
    @IBAction func goBack(sender: UIButton)
    {
        
    }
    
    @IBAction func send(sender: UIButton)
    {
        
        
    }
}