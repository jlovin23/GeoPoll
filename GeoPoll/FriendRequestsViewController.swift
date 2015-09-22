//
//  FriendRequestsViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/21/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FriendRequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var pending: Array<PFUser>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let userData: PFObject = PFUser.currentUser()!.objectForKey("userData") as! PFObject
        
        userData.fetchIfNeeded()
        
        pending = userData["requests"] as! Array<PFUser>
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pending.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        
        return cell
        
    }

}
