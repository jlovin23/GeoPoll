//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionTableView: UITableView!
    var popupDrawerIsShowing = false
    var questions: Array<PFObject> = [PFObject]()
    let fakeData = ["this", "thaat"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getQuestions()
        
        navigationController!.navigationBar.barTintColor = OurColors.ponderBlue
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        questionTableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func logoutPressed(sender: UIButton)
    {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    
    //get questions
    func getQuestions()
    {
        let user: PFUser = PFUser.currentUser()!
        
        let userData: PFObject = user["userData"] as! PFObject
        
        userData.fetchIfNeeded()
        
        let groups: Array<PFObject> = userData["groups"] as! Array<PFObject>
        
        for eachGroup in groups
        {
            eachGroup.fetchIfNeeded()
            let groupQuestions: Array<PFObject> = eachGroup["questions"] as! Array<PFObject>
            
            for quest in groupQuestions
            {
                questions.append(quest)
            }
        }
    }
    
    // MARK: Table View

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if questions.count > 0
        {
            return questions.count
        }
        else
        {
            return 1
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as!QuestionCell
        let cellAnswerButtons = [cell.option1, cell.option2, cell.option3, cell.option4]
        
        if questions.count > 0
        {
            questions[indexPath.row].fetchIfNeeded()
            cell.label.text = questions[indexPath.row].objectForKey("question") as! String
            //cell.sentFromName.text = questions[indexPath.row].objectForKey("creator") as! String
            cell.selectionStyle = .None
        }
        else
        {

            cell.hidden = true
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if questions.count > 0
        {
            cell.contentView.backgroundColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            let cardView : UIView = UIView(frame: CGRectMake(0, 10, self.view.frame.size.width + 20, 370))
            cardView.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
            cardView.layer.masksToBounds = false
            cardView.layer.cornerRadius = 1.5
            cardView.layer.shadowColor = UIColor.blackColor().CGColor
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowRadius = 2.5
            cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            
            cell.contentView.addSubview(cardView)
            cell.contentView.sendSubviewToBack(cardView)
        }
    }
    
    @IBAction func showAddQuestionPopup(sender: UIButton)
    {
        //performSegueWithIdentifier("showAddMenu", sender: self)
    }
    
    @IBAction func directOrLocalPressed(sender: UIButton)
    {
        performSegueWithIdentifier("goToQuestionCreation", sender: self)
    }
    
    
    @IBAction func accountMenuPressed(sender: UIButton)
    {
        performSegueWithIdentifier("showAccountPopup", sender: self)
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("showAddMenu", sender: self)
    }
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue)
    {}
    
    
}
