//
//  FriendRequestCell.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/22/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class FriendRequestCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var deny: UIButton!
    @IBOutlet weak var approve: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        approve.backgroundColor = OurColors.ponderGreen
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}