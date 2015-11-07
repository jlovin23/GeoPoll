//
//  QuestionCell.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/9/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class QuestionCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sentFromName: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var table: UITableView!
    
    var question: PFObject!
    var answers = []
    let data = ["dfsaf", "dsfa", "dsf"]
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .None
    }

    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if question != nil
        {
            question.fetchIfNeeded()
            return (question["answers"] as! Array<String>).count
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
        let cell = tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath)
        
        if question == nil
        {
            cell.textLabel!.text = ""
        }
        else
        {
            question?.fetchIfNeeded()
            cell.textLabel!.text = (question["answers"] as! Array<String>)[indexPath.row]
            cell.textLabel?.textColor = UIColor.whiteColor()
            
            if indexPath.row % 2 == 0
            {
                cell.backgroundColor = OurColors.lightPonderBlue
            }
            else
            {
                cell.backgroundColor = OurColors.ponderBlue
            }
        }
        
        return cell
    }
}