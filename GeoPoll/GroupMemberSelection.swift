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

    override func viewDidLoad() {
        
        let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
        userData.fetchIfNeeded()
        
        friends = userData["friends"] as! Array<PFUser>
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
