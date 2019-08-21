//
//  RoundButton.swift
//  LoginPage
//
//  Created by Monica Khoe on 20/08/19.
//  Copyright © 2019 Monica Khoe. All rights reserved.
//

import UIKit

class RoundButton: UIButton  {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.frame.height/4
        
    }
}
