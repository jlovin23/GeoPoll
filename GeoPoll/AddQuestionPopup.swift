//
//  AddQuestionPopup.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/10/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class AddQuestionPopup: UIViewController {

    @IBOutlet weak var directIcon: UIButton!
    @IBOutlet weak var directLabel: UIButton!
    @IBOutlet weak var localIcon: UIButton!
    @IBOutlet weak var localLabel: UIButton!
    @IBOutlet weak var addIcon: UIButton!
    @IBOutlet weak var addLabel: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var groupLabel: UIButton!
    
    
    @IBOutlet weak var downChevron: UIButton!
    
    var shouldGoToQuestionCreate: String!
    var questionType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downChevron.setTitleColor(OurColors.ponderBlue, forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        slideInAnItem(directIcon, delayTime: 0.0)
        slideInAnItem(directLabel, delayTime: 0.1)
        slideInAnItem(localIcon, delayTime: 0.15)
        slideInAnItem(localLabel, delayTime: 0.2)
        slideInAnItem(addIcon, delayTime: 0.25)
        slideInAnItem(addLabel, delayTime: 0.3)
    }
    
    override func viewDidLayoutSubviews() {
        setItemOffscreen(directIcon)
        setItemOffscreen(directLabel)
        setItemOffscreen(localIcon)
        setItemOffscreen(localLabel)
        setItemOffscreen(addIcon)
        setItemOffscreen(addLabel)
    }
    
    func slideInAnItem(item: UIButton, delayTime: Double){
        UIView.animateWithDuration(0.3, delay: delayTime, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            item.frame = CGRectMake(self.view.frame.size.width/2-item.frame.size.width/2, item.frame.origin.y, item.frame.size.width, item.frame.size.height)
            }, completion: nil)
    }
    
    func setItemOffscreen(item: UIButton)
    {
        item.frame = CGRectMake(self.view.frame.size.width + item.frame.size.width, item.frame.origin.y, item.frame.size.width, item.frame.size.height)
    }
    
    func slideOutAnItem(item: UIButton){
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            item.frame = CGRectMake(self.view.frame.size.width + item.frame.size.width, item.frame.origin.y, item.frame.size.width, item.frame.size.height)
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func directPressed(sender: UIButton)
    {
        questionType = "direct"
        performSegueWithIdentifier("goToCreate", sender: self)
    }
    
    @IBAction func localPressed(sender: UIButton)
    {
        questionType = "local"
        performSegueWithIdentifier("goToCreate", sender: self)
    }

    @IBAction func addFriendPressed(sender: UIButton)
    {
        performSegueWithIdentifier("addFriend", sender: self)
    }
    
    @IBAction func groupPressed(sender: UIButton)
    {
        performSegueWithIdentifier("memberSelection", sender: self)
    }
    
   
    @IBAction func dismissPressed(sender: UIButton) {
        UIView.animateWithDuration(0.7, animations: { () -> Void in
            self.view.alpha = 0
            self.slideOutAnItem(self.directIcon)
            self.slideOutAnItem(self.directLabel)
            self.slideOutAnItem(self.localIcon)
            self.slideOutAnItem(self.localLabel)
            self.slideOutAnItem(self.addIcon)
            self.slideOutAnItem(self.addLabel)
        }) { (success) -> Void in
            if success
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToCreate"
        {
            let destination = segue.destinationViewController as! CreateQuestionView
            
            if let quest = questionType
            {
                destination.questionType = quest
            }
            
        }
    }
}