//
//  NotificationModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 28/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit

class NotificationModel{
    var userPhoto: UIImage
    var userName: String
    var notificationTime: String
    
    init(userPhoto: UIImage, userName: String, notificationTime: String) {
        self.userPhoto = userPhoto
        self.userName = userName
        self.notificationTime = notificationTime
    }
}
