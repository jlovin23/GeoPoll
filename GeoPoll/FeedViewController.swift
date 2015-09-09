// MAKING CHANGES ON SECONDARY COMP
//  FeedViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/6/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController {
    
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownActionButton: UIButton!
    
<<<<<<< HEAD
    var popupDrawerIsShowing = false
=======
    var questions: Array<PFObject>!
>>>>>>> 71c05cb5ffb9a68961cb608d569339e7479780bd

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
        
        questions.sor
    }
    
    
    @IBAction func locationPressed(sender: UIButton) {
    }
    
    @IBAction func directPressed(sender: UIButton) {
    }
    

    @IBAction func addFriendPressed(sender: UIButton) {
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
}
