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
        
        let customBackView = UIView(frame: CGRectMake(0, 0, 100, self.navigationController!.navigationBar.frame.size.height))
        let arrowButton = UIButton()
        arrowButton.setTitle("←", forState: .Normal)
        arrowButton.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
        customBackView.addSubview(arrowButton)
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationItem.leftBarButtonItem?.customView = customBackView
    }

    func popBack(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func styleQuestionField()
    {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = OurColors.ponderBlue.CGColor
        border.frame = CGRect(x: 0, y: questionLabel.frame.size.height - width, width:  view.frame.size.width, height: questionLabel.frame.size.height)
        border.borderWidth = width
        
        questionLabel.layer.addSublayer(border)
        questionLabel.layer.masksToBounds = true
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
