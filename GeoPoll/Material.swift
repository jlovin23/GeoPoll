//
//  Material.swift
//  GeoPoll
//
//  Created by Joseph Lovinger on 9/12/15.
//  Copyright (c) 2015 Joseph Lovinger. All rights reserved.
//

import Foundation
import UIKit

class Material
{
    static func makeActionButton(button: UIButton, bgColor: UIColor)
    {
        button.layer.cornerRadius = 24
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOffset = CGSizeMake(0, 4)
        button.layer.shadowOpacity = 0.2
        button.backgroundColor = bgColor
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.opaque = true
    }
}