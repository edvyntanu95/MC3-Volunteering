//
//  FriendModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit

class FriendModel{
    var friendID: String?
    var friendPhoto: UIImage?
    var friendName: String?
    var lastActive: String?
    
    init(friendID: String, friendPhoto: UIImage, friendName: String?, lastActive: String?) {
        self.friendID = friendID
        self.friendPhoto = friendPhoto
        self.friendName = friendName
        self.lastActive = lastActive
    }
}
