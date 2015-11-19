//
//  ChoiceCell.swift
//  SmartAsk
//
//  Created by Joseph Lovinger on 11/18/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class ChoiceCell: UITableViewCell
{
    @IBOutlet var percentChosen: UILabel!
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
