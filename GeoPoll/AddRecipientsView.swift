//
//  AddRecipientsView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/24/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class AddRecipientsView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecipientCell
        
        cell.nameLabel.text = "hi"
        
        return cell
    }
    
    @IBAction func goBack(sender: UIButton)
    {
        
    }
    

}
