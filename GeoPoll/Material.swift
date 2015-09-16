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
    
    static func createBottomBorderForTextfield(field: UITextField){
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = OurColors.ponderBlue.CGColor
        border.frame = CGRect(x: 0, y: field.frame.size.height - width, width:  field.frame.size.width, height: field.frame.size.height)
        border.borderWidth = width
        
        field.layer.addSublayer(border)
        field.layer.masksToBounds = true
    }
}