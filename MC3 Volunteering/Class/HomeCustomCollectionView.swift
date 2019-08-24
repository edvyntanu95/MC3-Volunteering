//
//  CustomCollectionView.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class HomeCustomCollectionView: UICollectionViewCell {
    
    @IBOutlet weak var imageSliderHome: UIImageView!
    @IBOutlet weak var homeSliderNamaAcaraLabel: UILabel!
    
    @IBOutlet weak var homeSliderTempatAcaraLabel: UILabel!
    @IBOutlet weak var homeSliderTanggalAcaraLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(withDuration: 0) {
                self.imageSliderHome.transform = self.isSelected ? CGAffineTransform(scaleX: 0.98, y: 0.98) : CGAffineTransform.identity
                }
            } else {
                UIView.animate(withDuration: 0.1) {
                self.imageSliderHome.transform = self.isSelected ? CGAffineTransform(scaleX: 1, y: 1) : CGAffineTransform.identity
            }
            }
        }
    }
//    override var isSelected: Bool{
//        didSet{
//            UIView.animate(withDuration: 2.0) {
//                self.imageSliderHome.transform = self.isSelected ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity
//            }
//        }
//    }
}
    

