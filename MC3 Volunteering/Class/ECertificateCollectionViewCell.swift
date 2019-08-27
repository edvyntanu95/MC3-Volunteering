//
//  ECertificateCollectionViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class ECertificateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cetificateImageView: UIImageView!
    
    func setCell(model: UserModel, row: Int){
        self.cetificateImageView.image = model.userCertificates[row]
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
