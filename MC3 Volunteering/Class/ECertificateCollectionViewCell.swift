//
//  ECertificateCollectionViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit
class ECertificateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cetificateImageView: UIImageView!
    
    func setCell(certificate: CKRecord){
        if let asset = certificate[RemoteCertificates.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.cetificateImageView.image = UIImage(data: data)
            }
        }
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
