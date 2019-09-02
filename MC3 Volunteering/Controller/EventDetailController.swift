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
        registerEventAlone { (finished) in
            if finished == true {
                print("Daftar Event Berhasil")
            }else{
                print("Daftar Event Gagal")
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
    
}

extension EventDetailController: UNUserNotificationCenterDelegate{
    
    // This function will be called when the app receive notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // show the notification alert (banner), and with sound
        completionHandler([.alert, .sound])
    }
    
    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // tell the app that we have finished processing the user’s action (eg: tap on notification banner) / response
        completionHandler()
    }
    
    // When user allowed push notification and the app has gotten the device token
    // (device token is a unique ID that Apple server use to determine which device to send push notification to)
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // Create a subscription to the 'Notifications' Record Type in CloudKit
        // User will receive a push notification when a new record is created in CloudKit
        // Read more on https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/CloudKitQuickStart/SubscribingtoRecordChanges/SubscribingtoRecordChanges.html
        
        // The predicate lets you define condition of the subscription, eg: only be notified of change if the newly created notification start with "A"
        // the TRUEPREDICATE means any new Notifications record created will be notified
        let subscription = CKQuerySubscription(recordType: RemoteRecords.registerEvents, predicate: NSPredicate(format: "TRUEPREDICATE"), options: [.firesOnRecordCreation, .firesOnRecordUpdate, .firesOnRecordDeletion])
        
        // Here we customize the notification message
        let info = CKSubscription.NotificationInfo()
        
        // this will use the 'title' field in the Record type 'notifications' as the title of the push notification
        info.titleLocalizationKey = "%1$@"
        info.titleLocalizationArgs = [RemoteRegisterEvents.status]
        
        // if you want to use multiple field combined for the title of push notification
        // info.titleLocalizationKey = "%1$@ %2$@" // if want to add more, the format will be "%3$@", "%4$@" and so on
        // info.titleLocalizationArgs = ["title", "subtitle"]
        
        // this will use the 'content' field in the Record type 'notifications' as the content of the push notification
        info.alertLocalizationKey = "%1$@"
        info.alertLocalizationArgs = [RemoteRegisterEvents.userId]
        
        // increment the red number count on the top right corner of app icon
        info.shouldBadge = true
        
        // use system default notification sound
        info.soundName = "default"
        
        subscription.notificationInfo = info
        
        // Save the subscription to Public Database in Cloudkit
        DBConnection.share.publicDB.save(subscription, completionHandler: { subscription, error in
            if error == nil {
                // Subscription saved successfully
            } else {
                // Error occurred
            }
        })
        
    }
    
}
    
    

