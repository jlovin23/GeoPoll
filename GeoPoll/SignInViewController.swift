//
//  ViewController.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/5/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signinButton.backgroundColor = OurColors.ponderBlue
        signupButton.backgroundColor = OurColors.ponderGreen
        
        signinButton.layer.cornerRadius = 4.0
        signupButton.layer.cornerRadius = 4.0
    }
    
    override func viewDidLayoutSubviews() {
        createBottomBorderForTextfield(usernameField)
        createBottomBorderForTextfield(passwordField)
    }
    
    override func viewDidAppear(animated: Bool) {
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            self.performSegueWithIdentifier("signInSuccess", sender: self)
        } else {
            print(currentUser?.description)
        }
    }
    
    func createBottomBorderForTextfield(field: UITextField){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = OurColors.ponderBlue.CGColor
        border.frame = CGRect(x: 0, y: field.frame.size.height - width, width:  field.frame.size.width, height: field.frame.size.height)
        border.borderWidth = width
        
        field.layer.addSublayer(border)
        field.layer.masksToBounds = true
    }
    
    @IBAction func signinPressed(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text) { (success, error) -> Void in
            if error != nil {
                let alert = UIAlertController(title: "User does not exist", message: "No such user exists. You could try signing up.", preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(okButton)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.performSegueWithIdentifier("signInSuccess", sender: self)
            }
        }
    }
    
    @IBAction func signupPressed(sender: UIButton) {
        if usernameField.text != "" && passwordField.text != "" {
            let user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                if error != nil {
                    let alert = UIAlertController(title: "Invalid username", message: "A user with that username already exists. Please try another.", preferredStyle: .Alert)
                    let okButton = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                    alert.addAction(okButton)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    self.performSegueWithIdentifier("signInSuccess", sender: self)
                }
            })
        }
    }
}