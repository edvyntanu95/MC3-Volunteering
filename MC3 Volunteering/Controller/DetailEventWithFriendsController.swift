//
//  DetailEventWithFriendsController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class DetailEventWithFriendsController: UIViewController {
    
    @IBOutlet weak var viewRegisterBackground: UIView!
    @IBOutlet weak var viewRegisterFill: UIView!
    @IBOutlet weak var viewEventBackground: UIView!
    @IBOutlet weak var viewEventFill: UIView!
    @IBOutlet weak var viewCertificateBackground: UIView!
    @IBOutlet weak var viewCertificateFill: UIView!
    @IBOutlet weak var viewInvitedBackground: UIView!
    @IBOutlet weak var viewInvitedFill: UIView!
    
    @IBOutlet weak var iViewEvent: UIImageView!
    @IBOutlet weak var iViewEventOrganizer: UIImageView!
    @IBOutlet weak var viewOverlay: UIView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventDescriptions: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    @IBOutlet weak var lblEventTime: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventOrganizer: UILabel!
    
    @IBOutlet weak var buttonRegisterEvent: UIButton!
    
    var eventId:String?
    var imageEvent: UIImage?
    var imageEOPhoto: UIImage?
    
    var eventTitle: String?
    var numberOFfriends: String?
    var eventLocation: String?
    var eventTime: String?
    var eventDate: String?
    var eventOrganizer: String?
    var eventDescription: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpContent()
        

    }
    
    func setUpView(){
        viewInvitedBackground.layer.cornerRadius = viewInvitedBackground.frame.height/2
        viewInvitedFill.layer.cornerRadius = viewInvitedFill.frame.height/2
        
        viewRegisterBackground.layer.cornerRadius = viewRegisterBackground.frame.height/2
        viewRegisterFill.layer.cornerRadius = viewRegisterFill.frame.height/2
        
        viewEventBackground.layer.cornerRadius = viewEventBackground.frame.height/2
        viewEventFill.layer.cornerRadius = viewEventFill.frame.height/2
        
        viewCertificateBackground.layer.cornerRadius = viewCertificateBackground.frame.height/2
        viewCertificateFill.layer.cornerRadius = viewCertificateFill.frame.height/2
        
        iViewEventOrganizer.layer.cornerRadius = iViewEventOrganizer.frame.height/2
        iViewEventOrganizer.layer.masksToBounds = true
    }
    
    func setUpContent(){
        lblEventTitle.text = eventTitle
        lblEventLocation.text = eventLocation
        lblEventTime.text = eventTime
        lblEventDate.text = eventDate
        lblEventOrganizer.text = eventOrganizer
        lblEventDescriptions.text = eventDescription
        
        iViewEvent.image = imageEvent
        iViewEventOrganizer.image = imageEOPhoto
    }
    

  
}

extension DetailEventWithFriendsController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
