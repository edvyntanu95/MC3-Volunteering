//
//  NotificationTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 28/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivUserImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastActive: UILabel!

    func setCell(model: CKRecord){
        ivUserImage.layer.cornerRadius = 10
        ivUserImage.layer.masksToBounds = true

//        ivUserImage.image =
//        lblName.text =
//        lblLastActive.text =
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
