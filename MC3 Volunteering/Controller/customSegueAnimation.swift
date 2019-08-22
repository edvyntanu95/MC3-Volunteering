//
//  customSegueAnimation.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 22/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class customSegueAnimation: UIStoryboardSegue {

    override func perform() {
        
    }
    
    func slide (){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalcenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: (0.5), y: 0)
        toViewController.view.center = originalcenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
            
        })
    }
    
}
