//
//  friendListTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class friendListTableViewCell: UITableViewCell {
    
    var friendID = ""
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var lblFriendName: UILabel!
    @IBOutlet weak var lblLastActive: UILabel!
    
    func setFriendList(model: CKRecord){
        
        friendID = model.recordID.recordName
        
        if let asset = model[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.imageViewPhoto.image = UIImage(data: data)
            }
        }
        lblFriendName.text = model[RemoteUsers.name]
        lblLastActive.text = "18 Hours ago"
        
        print(friendID)
        
        imageViewPhoto.layer.cornerRadius = 10
        imageViewPhoto.layer.masksToBounds = true
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
