//
//  CustomCollectionView.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class HomeCustomCollectionView: UICollectionViewCell {
    
    var eventId:String?
    
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
    
    func setCell(model: CKRecord){
        
        if let asset = model[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.imageSliderHome.image = UIImage(data: data)
            }
        }
        homeSliderNamaAcaraLabel.text = model[RemoteEvents.name] as! String
        homeSliderTempatAcaraLabel.text = model[RemoteEvents.location] as! String
        homeSliderTanggalAcaraLabel.text = model[RemoteEvents.date
            ] as! String
    }
    
}
    

