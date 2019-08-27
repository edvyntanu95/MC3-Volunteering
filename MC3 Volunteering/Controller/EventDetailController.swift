//
//  EventDetailController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class EventDetailController: UIViewController{
    
    var imageEvent: UIImage?
    var imageFriendPhoto1: UIImage?
    var imageFriendPhoto2: UIImage?
    var imageFriendPhoto3: UIImage?
    var imageEOPhoto: UIImage?
    
    var eventTitle: String?
    var numberOFfriends: String?
    var eventLocation: String?
    var eventTime: String?
    var eventDate: String?
    var eventOrganizer: String?
    var eventDescription: String?
    
    @IBOutlet weak var judulDetailEventLabel: UILabel!
    @IBOutlet weak var lblNumberOfFriends: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblEventOrganizer: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var imageEventDetailed: UIImageView!
    @IBOutlet weak var imageFriend2: UIImageView!
    @IBOutlet weak var imageFriend1: UIImageView!
    @IBOutlet weak var imageFriend3: UIImageView!
    @IBOutlet weak var imageEventOrganizer: UIImageView!
    
    @IBOutlet var goAloneButton: UIButton!
    @IBOutlet var inviteFriendButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        goAloneButton.layer.borderColor = #colorLiteral(red: 0.3039953709, green: 0.6345664263, blue: 0.8838434815, alpha: 1)
        goAloneButton.layer.borderWidth = 1
        inviteFriendButton.layer.borderColor = #colorLiteral(red: 0.3039953709, green: 0.6345664263, blue: 0.8838434815, alpha: 1)
        inviteFriendButton.layer.borderWidth = 1
        imageFriend1.layer.cornerRadius = imageFriend1.frame.height / 2
        imageFriend2.layer.cornerRadius = imageFriend2.frame.height / 2
        imageFriend3.layer.cornerRadius = imageFriend3.frame.height / 2
        imageEventOrganizer.layer.cornerRadius = imageEventOrganizer.frame.height / 2
        
        setUpContent()
        setUpView()

    }
    
    func setUpContent(){
        judulDetailEventLabel.text = eventTitle
        lblNumberOfFriends.text = numberOFfriends
        lblLocation.text = eventLocation
        lblTime.text = eventTime
        lblDate.text = eventDate
        lblEventOrganizer.text = eventOrganizer
        lblDescription.text = eventDescription
        
        imageEventDetailed.image = imageEvent
        imageFriend2.image = imageFriendPhoto2
        imageFriend1.image = imageFriendPhoto1
        imageFriend3.image = imageFriendPhoto3
        imageEventOrganizer.image = imageEOPhoto
    }
    
    func setUpView(){
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
}
    
    

