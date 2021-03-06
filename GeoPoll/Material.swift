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
    
    static func styleBorderedButton(button: UIButton)
    {
        button.layer.borderColor = OurColors.ponderBlue.CGColor
        button.layer.borderWidth = 4
        
        button.backgroundColor = UIColor.whiteColor()
        button.setTitleColor(OurColors.ponderBlue, forState: .Normal)
        button.layer.cornerRadius = 5
    }
    
    static func showPercentageBar(cell: UITableViewCell, percentage: Double, question: String)
    {
        let cellFrame = CGRectMake(5, 5, (cell.contentView.frame.size.width - 10) * CGFloat(percentage/100), cell.contentView.frame.size.height-10)
        let originalCellFrame = CGRectMake(5, 5, 0, cell.contentView.frame.size.height)
        let bar = UIView(frame: originalCellFrame)
        bar.backgroundColor = OurColors.ultraLightPonderBlue
        bar.layer.cornerRadius = 5
        
        let labelFrame = CGRectMake(5, 0, (cell.contentView.frame.size.width - 10) * CGFloat(percentage/100), 20)
        let titleLabel = UILabel(frame: labelFrame)
        titleLabel.text = question
        titleLabel.textColor = UIColor.whiteColor()
        
        let percentageFrame = CGRectMake(5, 20, 200 * CGFloat(percentage/100), 20)
        let percentageLabel = UILabel(frame: percentageFrame)
        percentageLabel.text = "\(Int(percentage))%"
        percentageLabel.textColor = UIColor.blackColor()
        
        bar.addSubview(titleLabel)
        bar.addSubview(percentageLabel)
        cell.addSubview(bar)

        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: { () -> Void in
            bar.frame = cellFrame
            }, completion: nil)
    }
}