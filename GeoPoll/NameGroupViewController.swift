//
//  NameGroupViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 10/13/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class NameGroupViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Material.createBottomBorderForTextfield(nameField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func create(sender: UIButton)
    {
        performSegueWithIdentifier("groupNamed", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "groupNamed"
        {
            let dest = segue.destinationViewController as! GroupMemberSelection
            dest.groupName = nameField.text
        }
    }
}
