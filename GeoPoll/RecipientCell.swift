//
//  RecipientCell.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/24/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class RecipientCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addedLabel.textColor = UIColor.whiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
