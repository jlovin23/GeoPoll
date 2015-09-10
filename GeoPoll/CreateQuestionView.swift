//
//  CreateQuestionView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/10/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class CreateQuestionView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OptionCell
        
        cell.optionTextField.placeholder = "Option \(indexPath.row + 1)"
        cell.selectionStyle = .None
        
        return cell
        
    }
    
    
    @IBAction func addOption(sender: UIButton)
    {
    }

}
