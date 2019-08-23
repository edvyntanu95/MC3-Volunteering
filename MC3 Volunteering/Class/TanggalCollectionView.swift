//
//  TanggalCollectionView.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 23/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class TanggalCollectionView: UICollectionViewCell {
    @IBOutlet weak var tanggalAcaraLabel: UILabel!
    @IBOutlet weak var bulanAcaraLabel: UILabel!
    
    func customFontLabelTanggal() {
        tanggalAcaraLabel.textColor = #colorLiteral(red: 0.7764705882, green: 0.6078431373, blue: 0.1098039216, alpha: 1)
        bulanAcaraLabel.textColor = #colorLiteral(red: 0.7764705882, green: 0.6078431373, blue: 0.1098039216, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.6078431373, blue: 0.1098039216, alpha: 1)
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
    
}
