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
        let cell = tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as! ChoiceCell
        
        if question == nil
        {
            cell.title.text = ""
        }
        else
        {
            question?.fetchIfNeeded()
            cell.title.text = (question["answers"] as! Array<String>)[indexPath.row]
            cell.title.textColor = UIColor.blackColor()
            cell.percentChosen.textColor = UIColor.clearColor()
        }
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let user: PFUser = PFUser.currentUser()!
        
        let userData:PFObject = user["userData"] as! PFObject
        
        userData.fetchIfNeeded()
        
        var answeredQuestions: Array<PFObject> = userData["answeredQuestions"] as! Array<PFObject>
        answeredQuestions.append(question)
        userData["answeredQuestions"] = answeredQuestions
        userData.save()

        
        question.fetchIfNeeded()
        var results: Array<Array<PFUser>> = question["results"] as! Array<Array<PFUser>>
        
        var answerResults: Array<PFUser> = results[indexPath.row]
        
        answerResults.append(PFUser.currentUser()!)
        
        results[indexPath.row] = answerResults
        
        question["results"] = results
        
        question.saveInBackground()
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChoiceCell
        
        Material.showPercentageBar(cell, percentage: 90)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: { () -> Void in
            cell.title.frame = CGRectMake(cell.frame.origin.x + 30, cell.title.frame.origin.y, cell.title.frame.size.width, cell.title.frame.size.height)
            }, completion: nil)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let smallFrame = CGRectMake(5, 5, cell.contentView.frame.size.width - 10, cell.contentView.frame.size.height - 10)
        let smallBackground = UIView(frame: smallFrame)
        
        smallBackground.backgroundColor = OurColors.ponderBlue
        smallBackground.layer.cornerRadius = 5
        cell.contentView.addSubview(smallBackground)
        cell.contentView.sendSubviewToBack(smallBackground)
    }
}