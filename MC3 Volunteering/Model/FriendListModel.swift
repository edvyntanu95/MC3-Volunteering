//
//  FriendListModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation

class FriendListModel{
    var friendListID : String?
    var userID : String?
    var friendsID : [String]
    
    init(friendListID: String, userID: String, friendsID: [String]) {
        self.friendListID = friendListID
        self.userID = userID
        self.friendsID = friendsID
    }
}
