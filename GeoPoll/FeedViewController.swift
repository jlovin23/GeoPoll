// MAKING CHANGES ON SECONDARY COMP
//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownActionButton: UIButton!
    @IBOutlet weak var questionTableView: UITableView!
    
    var popupDrawerIsShowing = false
    enum QuestionTypes
    {
        case Direct
        case Local
    }
    var questionType: QuestionTypes?
    var questions: Array<PFObject>!
    let fakeData = ["this", "thaat"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-dropdownActionButton.frame.size.height, dropdownView.frame.size.width, dropdownView.frame.size.height)
    }
    
    @IBAction func logoutPressed(sender: UIBarButtonItem)
    {
        PFUser.logOutInBackgroundWithBlock { (error) -> Void in
            if error == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    //get questions
    func getQuestions ()
    {
        let user: PFUser = PFUser.currentUser()!
        
        let userData: PFObject = user["userData"] as! PFObject
        
        userData.fetchIfNeeded()
        
        let groups: Array<PFObject> = userData["groups"] as! Array<PFObject>
        
        questions = [PFObject]()
        
        for eachGroup in groups
        {
            let groupQuestions: Array<PFObject> = eachGroup["questions"] as! Array<PFObject>
            
            for quest in groupQuestions
            {
                questions.append(quest)
            }
        }
    }
    
    
    @IBAction func locationPressed(sender: UIButton)
    {
        questionType = .Local
        
    }
    
    @IBAction func directPressed(sender: UIButton)
    {
        questionType = .Direct
    }
    
    @IBAction func addFriendPressed(sender: UIButton)
    {
    }
    
    @IBAction func dropdownActionButtonPressed(sender: UIButton)
    {
        if popupDrawerIsShowing {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-self.dropdownActionButton.frame.size.height, self.dropdownView.frame.size.width, self.dropdownView.frame.size.height)
            }, completion: nil)
            
            popupDrawerIsShowing = false
        } else {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.dropdownView.frame = CGRectMake(0, self.view.frame.size.height-self.dropdownView.frame.size.height, self.dropdownView.frame.size.width, self.dropdownView.frame.size.height)
                }, completion: nil)
            popupDrawerIsShowing = true
        }
    }
    
    // MARK: Table View

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeData.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! QuestionCell
        
        cell.label.text = fakeData[indexPath.row]
        
        return cell
        
    }
    
}
