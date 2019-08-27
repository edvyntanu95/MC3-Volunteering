//
//  friendListTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class friendListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var lblFriendName: UILabel!
    @IBOutlet weak var lblLastActive: UILabel!
    
    func setFriendList(model: FriendModel){
        imageViewPhoto.image = model.friendPhoto
        lblFriendName.text = model.friendName
        lblLastActive.text = model.lastActive
        
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
