//
//  DetailEventWithFriendsController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

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
    
    @IBOutlet weak var tableViewFriend: UITableView!
    
    var friend:[CKRecord] = []
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
    var eventStatus: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpContent()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewFriend.reloadData()
        viewInvitedFill.alpha = 0
        viewRegisterFill.alpha = 0
        viewEventFill.alpha = 0
        viewCertificateFill.alpha = 0
        if eventStatus == "Invited" {
            UIView.animate(withDuration: 0.3) {
                self.viewInvitedFill.alpha = 1
            }
            if eventStatus == "Registered" {
                UIView.animate(withDuration: 0.3) {
                    self.viewRegisterFill.alpha = 1
                }
                if eventStatus == "Event" {
                    UIView.animate(withDuration: 0.3) {
                        self.viewEventFill.alpha = 1
                    }
                    
                    if eventStatus == "Certificate" {
                        UIView.animate(withDuration: 0.3) {
                            self.viewCertificateFill.alpha = 1
                        }
                    }
                }
            }
        }
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
        return friend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFriendsCell", for: indexPath) as! DetailEventFriendsTableViewCell
        let myFriend = friend[indexPath.row]
        cell.lblFriendsName.text = myFriend[RemoteUsers.name]
        cell.lblFriendStatus.text = "Pending"
        if let asset = myFriend[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                cell.iViewFriendsPhoto.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
}
