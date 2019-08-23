//
//  PreferenceRoleCollectionViewCell.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 23/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class PreferenceRoleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var preferenceRoleImage: UIImageView!
    
    func customSliderPR (){
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
