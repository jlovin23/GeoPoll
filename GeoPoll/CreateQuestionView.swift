//
//  CreateQuestionView.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/10/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit
import Parse

class CreateQuestionView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addOptionButton: UIButton!
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    var numberOfOptions = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .None
        addOptionButton.backgroundColor = OurColors.ponderBlue
        addOptionButton.layer.cornerRadius = 4
        
        styleQuestionField()
        
        cancelButton.backgroundColor = OurColors.ponderBlue
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        checkButton.backgroundColor = OurColors.ponderBlue
        checkButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
    }
    
    func saveQuestion()
    {
        var addQuestion: PFObject = PFObject(className: "Question")
        var answers: Array<String> = [String]()
        var results: Array<Array<PFUser>> = [Array]()
        addQuestion["question"] = questionLabel.text
        
        for var sec = 0; sec <= tableView.numberOfSections() - 1; sec++
        {
            for var row = 0; row <= tableView.numberOfRowsInSection(sec); row++
        {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: sec)) as! OptionCell
            
            answers.append(cell.optionTextField.text)
            
            results.append([PFUser]())
            }
        }
    }
    
    func styleQuestionField()
    {
        questionLabel.backgroundColor = OurColors.ponderBlue
        questionLabel.textColor = UIColor.whiteColor()
        questionLabel.tintColor = UIColor.whiteColor()
        questionLabel.attributedPlaceholder = NSAttributedString(string:"Question",
            attributes:[NSForegroundColorAttributeName: OurColors.ultraLightGray])
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
        Material.createBottomBorderForTextfield(cell.optionTextField)
        cell.questionNumberField.text = "\(indexPath.row + 1)"
        cell.questionNumberField.textColor = OurColors.ponderBlue
        
        return cell
        
    }
    
    @IBAction func addOption(sender: UIButton)
    {
        numberOfOptions++
        tableView.reloadData() 
    }

    @IBAction func cancelPressed(sender: UIButton)
    {
        //performSegueWithIdentifier("dismissQuestionCreate", sender: self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func confirmPressed(sender: UIButton)
    {
    }
    
}
