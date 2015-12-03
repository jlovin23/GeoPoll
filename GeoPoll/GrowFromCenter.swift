//
//  GrowFromCenter.swift
//  SmartAsk
//
//  Created by Joseph Lovinger on 11/26/15.
//  Copyright © 2015 Joseph Lovinger. All rights reserved.
//

import UIKit

class GrowFromCenter: UIStoryboardSegue
{
    override func perform()
    {
        let sourceVC = self.sourceViewController
        let destinationVC = self.destinationViewController

        sourceVC.view.addSubview(destinationVC.view)
        
        destinationVC.view.frame = CGRectMake(600, destinationVC.view.frame.origin.y, destinationVC.view.frame.size.width, destinationVC.view.frame.size.height)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .CurveEaseIn, animations: { () -> Void in
            destinationVC.view.center = sourceVC.view.center
            }) { (finished) -> Void in
                destinationVC.view.removeFromSuperview()
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
                
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    sourceVC.presentViewController(destinationVC, animated: false, completion: nil)
                })
        }
    }
}
