//
//  FriendRequestsView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/22/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FriendRequestsView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UIView!
    var pending = [PFUser]() //Array<PFUser>!
    @IBOutlet weak var noRequestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updatePending()
        
        navBar.backgroundColor = OurColors.ponderBlue
        print(pending.count)
    }
    
    func updatePending()
    {
        if let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as? PFObject
        {
            userData.fetchIfNeeded()
            pending = userData["requests"] as! Array<PFUser>
        }
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pending.count > 0
        {
            return pending.count
        }
        else
        {
            return 1
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FriendRequestCell
        
        if pending.count > 0
        {
            pending[indexPath.row].fetchIfNeeded()
            cell.nameLabel.text = pending[indexPath.row].username
            cell.index = indexPath.row
            cell.requests = pending
            
            cell.deny.hidden = false
            cell.approve.hidden = false
            
            cell.deny.userInteractionEnabled = true
            cell.approve.userInteractionEnabled = true
        }
        else
        {
            cell.nameLabel.text = ""
            
            cell.deny.hidden = true
            cell.approve.hidden = true
            
            cell.deny.userInteractionEnabled = false
            cell.approve.userInteractionEnabled = false
        }
        
        return cell
    }
    
    @IBAction func rejectPressed(sender: UIButton)
    {
    }
    
    @IBAction func acceptPressed(sender: UIButton)
    {
        print("view method called")
        updatePending()
        tableView.reloadData()
    }
    
}