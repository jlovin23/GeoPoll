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
    @IBOutlet weak var createFab: UIButton!
    @IBOutlet weak var directFab: UIButton!
    @IBOutlet weak var localFab: UIButton!
    @IBOutlet weak var addFriendFab: UIButton!
    
    var popupDrawerIsShowing = false
    enum QuestionTypes
    {
        case Direct
        case Local
    }
    var questionType: QuestionTypes?
    var questions: Array<PFObject>!
    let fakeData = ["this", "thaat"]
    var showingFabs = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barTintColor = OurColors.ponderBlue
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        questionTableView.separatorStyle = .None
        
        Material.makeActionButton(createFab, bgColor: OurColors.ponderBlue)
        Material.makeActionButton(directFab, bgColor: OurColors.easterGreen)
        Material.makeActionButton(localFab, bgColor: OurColors.easterPurple)
        Material.makeActionButton(addFriendFab, bgColor: OurColors.easterYellow)
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
        cell.selectionStyle = .None
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.contentView.backgroundColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        let cardView : UIView = UIView(frame: CGRectMake(self.view.frame.size.width * 0.05, 10, self.view.frame.size.width * 0.9, 130))
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
    
    @IBAction func showAddQuestionPopup(sender: UIButton)
    {
        performSegueWithIdentifier("showAddMenu", sender: self)
    }
    
    @IBAction func createFabPressed(sender: UIButton)
    {
        if showingFabs
        {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.directFab.frame = CGRectMake(self.createFab.frame.origin.x, self.directFab.frame.origin.y, self.directFab.frame.size.width, self.directFab.frame.size.height)
                self.localFab.frame = CGRectMake(self.createFab.frame.origin.x, self.localFab.frame.origin.y, self.localFab.frame.size.width, self.localFab.frame.size.height)
                self.addFriendFab.frame = CGRectMake(self.createFab.frame.origin.x, self.addFriendFab.frame.origin.y, self.addFriendFab.frame.size.width, self.addFriendFab.frame.size.height)
                }, completion: nil)
            showingFabs = false
        }
        else
        {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.directFab.frame = CGRectMake(self.directFab.frame.origin.x - self.directFab.frame.size.width - 10, self.directFab.frame.origin.y, self.directFab.frame.size.width, self.directFab.frame.size.height)
                self.localFab.frame = CGRectMake(self.localFab.frame.origin.x - self.localFab.frame.size.width * 2 - 20, self.localFab.frame.origin.y, self.localFab.frame.size.width, self.localFab.frame.size.height)
                self.addFriendFab.frame = CGRectMake(self.addFriendFab.frame.origin.x - self.addFriendFab.frame.size.width*3 - 30, self.addFriendFab.frame.origin.y, self.addFriendFab.frame.size.width, self.addFriendFab.frame.size.height)
                }, completion: nil)
            showingFabs = true
        }
    }
    
    @IBAction func directOrLocalPressed(sender: UIButton)
    {
        performSegueWithIdentifier("goToQuestionCreation", sender: self)
    }
    
    @IBAction func addFriendPressed(sender: UIButton)
    {
    }
    
}
