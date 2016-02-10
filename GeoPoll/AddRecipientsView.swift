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
        //choose selected group
        let selectedGroup = groups[indexPath.row]
        //get array of group members
        selectedGroup.fetchIfNeeded()
        print("Group: \(selectedGroup.description)")
        let members = selectedGroup["members"] as! Array<PFUser>
        
        let currentData = PFUser.currentUser()?.objectForKey("userData") as! PFObject
        currentData.fetchIfNeeded()
        var currentAsked = currentData["askedQuestions"] as! Array<PFObject>
        currentAsked.append(question)
        currentData["askedQuestions"] = currentAsked
        currentData.saveInBackground()
        
        
        print(PFUser.currentUser())
        print(members[0])
//        print(members[0])
//        let memberUserData = members[0]["userData"] as! PFObject
//        memberUserData.fetchIfNeeded()
//        print("Member user data: \(memberUserData)")
//        var membersAsked = memberUserData["askedQuestions"] as! Array<PFObject>
//        print("Member asked questions: \(membersAsked)")
//        membersAsked.append(question)
//        memberUserData["askedQuestions"] = membersAsked
//        memberUserData.saveInBackground()

        //penetrate group members userData and add questions to their array of incoming questions
        
        //dismiss view controller
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