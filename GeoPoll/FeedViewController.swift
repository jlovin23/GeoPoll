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
    
    var questions: Array<PFObject>!

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
    @IBAction func dropdownActionButtonPressed(sender: UIButton) {
    }
}
