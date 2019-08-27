//
//  EventModel.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import UIKit

class EventModel{
    var eventID: String
    var eventName: String
    var eventDescription: String
    var eventLocation: String
    var eventDate: String
    var eventPhoto: UIImage
    var eventTime: String
    var eventFee: Int
    var eventOrganizer: String
    var userIDs: [String]
    
    init(eventID:String, eventName:String, eventDescription: String, eventLocation: String, eventDate: String, eventPhoto: UIImage, eventTime: String, eventFee: Int, eventOrganizer: String, userIDs: [String]) {
        self.eventID = eventID
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventPhoto = eventPhoto
        self.eventTime = eventTime
        self.eventFee = eventFee
        self.eventOrganizer = eventOrganizer
        self.userIDs = userIDs
    }
}
