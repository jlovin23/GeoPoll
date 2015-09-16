//
//  AddFriendView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/16/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class AddFriendView: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sendRequestButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        styleFieldsAndButtons()
    }
    
    override func viewDidLayoutSubviews() {
        Material.createBottomBorderForTextfield(usernameField)
    }
    
    func styleFieldsAndButtons()
    {
        titleLabel.backgroundColor = OurColors.ponderBlue
        cancelButton.backgroundColor = OurColors.ponderBlue
        sendRequestButton.backgroundColor = OurColors.ponderBlue
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sendRequestButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        titleLabel.textColor = UIColor.whiteColor()
    }
    
    @IBAction func cancel(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendRequest(sender: UIButton)
    {
    }
}
