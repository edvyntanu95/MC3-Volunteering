//
//  ClickableTableViewCell.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class ClickableTableViewCell: UITableViewCell {
    
    @IBOutlet var gambar: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var lblLastActive: UILabel!
    
    func setInviteYourFriends(model: FriendModel){
        gambar.image = model.friendPhoto
        lblName.text = model.friendName
        lblLastActive.text = model.lastActive
        
        gambar.layer.cornerRadius = gambar.frame.height/2
        gambar.layer.masksToBounds = true
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    //    class CheckableTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    //    }
    
}
