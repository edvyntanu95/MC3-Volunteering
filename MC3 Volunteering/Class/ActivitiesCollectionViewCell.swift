//
//  ActivitiesCollectionViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class ActivitiesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageCard: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var imageFriend1: UIImageView!
    @IBOutlet weak var imageFriend2: UIImageView!
    @IBOutlet weak var imageFriend3: UIImageView!
    
    func setCell(myActivity: CKRecord, myActivityStatus: CKRecord){
        if let asset = myActivity[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.backgroundImageCard.image = UIImage(data: data)
            }
        }
    
        lblStatus.text = myActivityStatus[RemoteRegisterEvents.status] as! String
        lblTitle.text = myActivity[RemoteEvents.name] as! String
        lblLocation.text = myActivity[RemoteEvents.location] as! String
        lblDate.text = myActivity[RemoteEvents.date] as! String
        
        backgroundImageCard.layer.cornerRadius = 10
        imageFriend1.layer.cornerRadius = imageFriend1.frame.height/2
        imageFriend2.layer.cornerRadius = imageFriend2.frame.height/2
        imageFriend3.layer.cornerRadius = imageFriend3.frame.height/2
        
        lblStatus.textColor = #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)
        lblStatus.layer.cornerRadius = 10
        lblStatus.layer.masksToBounds = true
        
        if myActivityStatus[RemoteRegisterEvents.status] as! String == "Registered"{
            lblStatus.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.6941176471, blue: 0.7843137255, alpha: 1)
        } else if myActivityStatus[RemoteRegisterEvents.status] as! String == "On Progress" {
            lblStatus.backgroundColor = #colorLiteral(red: 0.6862745098, green: 0.9176470588, blue: 0.8901960784, alpha: 1)
        } else if myActivityStatus[RemoteRegisterEvents.status] as! String == "Completed" {
            lblStatus.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.8156862745, blue: 0.6196078431, alpha: 1)
        }
        
    }
    
}
