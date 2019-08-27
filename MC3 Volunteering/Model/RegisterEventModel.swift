//
//  RegisterEventModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit

class RegisterEventModel{
    var registerEventID: String
    var userID: String
    var eventID: String
    var eventPhoto: UIImage
    var eventName: String
    var eventDescription: String
    var eventLocation: String
    var eventDate: String
    var eventTime: String
    var eventOrganizer: String
    var status: String
    
    var friendPhoto1: UIImage
    var friendPhoto2: UIImage
    var friendPhoto3: UIImage
    
    init(registerEventID: String, userID: String, eventID: String, eventPhoto: UIImage, eventName: String, eventDescription: String, eventLocation: String, eventDate: String, eventTime: String, eventOrganizer: String, status: String, friendPhoto1: UIImage, friendPhoto2: UIImage, friendPhoto3: UIImage) {
        self.registerEventID = registerEventID
        self.userID = userID
        self.eventID = eventID
        self.eventPhoto = eventPhoto
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventOrganizer = eventOrganizer
        self.status = status
        self.friendPhoto1 = friendPhoto1
        self.friendPhoto2 = friendPhoto2
        self.friendPhoto3 = friendPhoto3
    }
}
