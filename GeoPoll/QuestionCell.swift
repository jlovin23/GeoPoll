//
//  QuestionCell.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/9/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sentFromName: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var divider: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        Material.styleBorderedButton(option1)
        Material.styleBorderedButton(option2)
        Material.styleBorderedButton(option3)
        Material.styleBorderedButton(option4)
        
        divider.layer.shadowColor = UIColor.blackColor().CGColor
        divider.layer.shadowOffset = CGSizeMake(0, 2)
        divider.layer.shadowOpacity = 0.2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
