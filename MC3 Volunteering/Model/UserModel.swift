//
//  UserModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit

class UserModel{
    var userID: String
    var userName: String
    var userPass: String
    var userEmail: String
    var userPhoto: UIImage
    var userRole: String
    var userCertificates: [UIImage]
    var userLocation: String
    var userBioDesc: String
    
    init(userID:String, userName:String, userPass: String, userEmail: String, userPhoto: UIImage, userRole: String, userLocation: String, userBioDesc: String, userCertificates: [UIImage]) {
        self.userID = userID
        self.userName = userName
        self.userPass = userPass
        self.userEmail = userEmail
        self.userPhoto = userPhoto
        self.userRole = userRole
        self.userLocation = userLocation
        self.userBioDesc = userBioDesc
        self.userCertificates = userCertificates
    }
}
