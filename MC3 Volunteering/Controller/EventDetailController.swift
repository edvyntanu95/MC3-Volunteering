//
//  EventDetailController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit
import UserNotifications
import UserNotificationsUI
import NotificationCenter
import MessageUI

class EventDetailController: UIViewController{
    
    var eventId:String?
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
    
    
    
    @IBAction func tapToSMS(_ sender: UIButton) {
        makeASMS()
        
    }
    
    @IBAction func tapToCall(_ sender: UIButton) {
        makeAPhoneCall()
    }
    
    func makeASMS(){
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hai Kak Saya Ingin Mengikuti Event Ini, Apakah Masih Tersedia Slotnya ?"
            controller.recipients = ["087889901930"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://087889901930")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    
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
    
    @IBAction func registerEventAloneTapped(_ sender: UIButton) {
        DispatchQueue.global().async {
            self.registerEventAlone { (finished) in
                if finished == true {
                    print("Daftar Event Berhasil")
                    DispatchQueue.main.async {
                        self.nextPage()
                    }
                    
                }else{
                    print("Daftar Event Gagal")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inviteFriend" {
            if let destinationVC = segue.destination as? FriendListController {
                destinationVC.eventId = eventId!
            }
        }
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
    
    func registerEventAlone(completionHandler: @escaping (_ finished: Bool) -> Void){
        var userDF = UserDefaults.standard
        var recordEventID = CKRecord.ID(recordName: eventId!)
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        var recordRegisterEvent = CKRecord(recordType: RemoteRecords.registerEvents)
    
        print("Record ID EVENT : \(recordEventID)")
        print("Record ID USER : \(recordUserID)")
    
        recordRegisterEvent[RemoteRegisterEvents.eventId] = CKRecord.Reference(recordID: recordEventID, action: .deleteSelf)
        recordRegisterEvent[RemoteRegisterEvents.userId] = CKRecord.Reference(recordID: recordUserID, action: .deleteSelf)
        recordRegisterEvent[RemoteRegisterEvents.status] = "Registered" as! NSString
        DBConnection.share.publicDB.save(recordRegisterEvent) { (record, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                print(record)
                completionHandler(true)
            }
        }
    }
    
    func nextPage(){
        
        let from = storyboard?.instantiateViewController(withIdentifier: "EventDetailController") as? EventDetailController
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyActivitiesDetailsPage") as? MyActivitiesDetailsPage
//        let myActivity = myActivitiesEventList[indexPath.row]
//        let myActivityStatus = myActivitiesEventsListStatus[indexPath.row]
//
//        let eventRecordID = myActivity.recordID.recordName as! String
//        vc?.eventId = eventRecordID
        vc?.eventTitle = eventTitle
        vc?.eventDescriptions = eventDescription
        vc?.eventLocation = eventLocation
        vc?.eventTime = eventTime
        vc?.eventDate = eventDate
        vc?.eventOrganizer = eventOrganizer
        vc?.numberOFfriends = "3 more friends joins"
        vc?.eventImage = imageEvent

        self.navigationController?.pushViewController(vc!, animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension EventDetailController: MFMessageComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
    
    

