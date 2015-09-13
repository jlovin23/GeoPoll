//
//  CreateQuestionView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/10/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class CreateQuestionView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addOptionButton: UIButton!
    @IBOutlet weak var questionLabel: UITextField!
    
    var numberOfOptions = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .None
        addOptionButton.backgroundColor = OurColors.ponderBlue
        addOptionButton.layer.cornerRadius = 4
        
        styleQuestionField()
        
        var backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backBtn.setImage(UIImage(named: "back_arrow"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: "popBack", forControlEvents:  UIControlEvents.TouchUpInside)
        let realBack = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = realBack
        
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveQuestion")
        
        let recognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "popBack")
        recognizer.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(recognizer)
    }
    
    func saveQuestion()
    {
        // ADD THE PARSE TO SAVE THE QUESTION HERE
    }

    func popBack()
    {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func styleQuestionField()
    {
        questionLabel.backgroundColor = OurColors.ponderBlue
        questionLabel.textColor = UIColor.whiteColor()
        questionLabel.tintColor = UIColor.whiteColor()
        questionLabel.attributedPlaceholder = NSAttributedString(string:"Question",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    }
    
    // MARK: Table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfOptions
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! OptionCell
        
        cell.optionTextField.placeholder = "Option \(indexPath.row + 1)"
        cell.selectionStyle = .None
        cell.optionTextField.layer.cornerRadius = 4.0
        cell.optionTextField.layer.borderColor = OurColors.ponderBlue.CGColor
        cell.optionTextField.layer.borderWidth = 2
        cell.questionNumberField.text = "\(indexPath.row + 1)"
        cell.questionNumberField.textColor = OurColors.ponderBlue
        
        return cell
        
    }
    
    
    @IBAction func addOption(sender: UIButton)
    {
        numberOfOptions++
        tableView.reloadData() 
    }

}
