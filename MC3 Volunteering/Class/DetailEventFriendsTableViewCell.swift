//
//  DetailEventFriendsTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class DetailEventFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var iViewFriendsPhoto: UIImageView!
    @IBOutlet weak var lblFriendsName: UILabel!
    @IBOutlet weak var lblFriendStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
