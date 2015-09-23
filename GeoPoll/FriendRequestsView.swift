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
    var pending: Array<PFUser>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
        userData.fetchIfNeeded()
        pending = userData["requests"] as! Array<PFUser>
        
        navBar.backgroundColor = OurColors.ponderBlue
        print(pending.count)
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pending.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FriendRequestCell
        pending[indexPath.row].fetchIfNeeded()
        
        cell.nameLabel.text = pending[indexPath.row].username
        cell.index = indexPath.row
        cell.requests = pending
        
        return cell
    }
    
    @IBAction func rejectPressed(sender: UIButton)
    {

    }
    
    @IBAction func acceptPressed(sender: UIButton)
    {
    }
}