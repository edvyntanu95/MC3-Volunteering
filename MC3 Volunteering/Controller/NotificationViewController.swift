//
//  NotificationViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 28/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class NotificationViewController: UIViewController {
    var notificationList = [CKRecord]()
    var notificationDetail = [CKRecord]()
    var selectedNotification:String?
    // ========= outlets for pop up view
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var ivEventPhoto: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDateAndTime: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    @IBOutlet weak var buttonSeeDetail: UIButton!
    @IBOutlet weak var buttonDecline: UIButton!
    @IBOutlet weak var buttonAccept: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var notificationTV: UITableView!
    
    // ========== var for logics
    
    var notifList : [CKRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationList = []
        notificationDetail = []
        DispatchQueue.global().async {
            self.getNotificationList { (finished) in
                if finished{
                    DispatchQueue.main.async {
                        self.notificationTV.reloadData()
                    }
                }
            }
        }
        
        visualEffectView.isHidden = true
        setUpButtons()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NotificationViewController.userDidTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(NotificationViewController.userDidTapped))
        
        popUpView.addGestureRecognizer(tap)
        visualEffectView.addGestureRecognizer(tap2)
    }
    
    
    @IBAction func acceptTapped(_ sender: UIButton) {
        DispatchQueue.global().async {
            self.addFriend(completionHandler: { (finished) in
                if finished{
                    DispatchQueue.main.async {
                        print("Friend Berhasil Di Accept")
                    }
                }
            })
        }
    }
    
    
    @objc func userDidTapped(tap: UITapGestureRecognizer){
        if popUpView.alpha == 1 {
            animateOut()
        }
    }
    
    
    func setUpButtons(){
        buttonDecline.layer.borderWidth = 0.5
        buttonDecline.layer.borderColor = #colorLiteral(red: 0.875795722, green: 0.3232465982, blue: 0.2720501125, alpha: 1)
        buttonDecline.tintColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        
        buttonDecline.layer.cornerRadius = 10
        buttonDecline.layer.masksToBounds = true
        
        buttonAccept.layer.cornerRadius = 10
        buttonAccept.layer.masksToBounds = true
    }
    
    func animateIn(){
        self.view.addSubview(popUpView)
        
        popUpView.center = self.view.center
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        
        
        tabBarController?.tabBar.alpha = 0.5
        tabBarController?.tabBar.isUserInteractionEnabled = false
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
        
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut(){
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        self.navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            self.popUpView.alpha = 0
            self.visualEffectView.isHidden = true
            self.tabBarController?.tabBar.alpha = 1.0
        }) { (success: Bool) in
            self.popUpView.removeFromSuperview()
            
        }
    }
    
    func getNotificationList(completionHandler:@escaping(_ finished: Bool) -> Void){
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        let predicate = NSPredicate(format: "receiverID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.notifications, predicate: predicate)
        
        
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                var recordNames:[CKRecord.ID] = []
                for record in records {
                    let senderReference = record[RemoteNotifications.senderID] as! CKRecord.Reference
                    self.notificationDetail.append(record)
                    recordNames.append(senderReference.recordID)
                }
                
                //                print(recordNames.count)
                
                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
                operation.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.notificationList.append(value)
                    }
                    completionHandler(true)
                }
                DBConnection.share.publicDB.add(operation)
            }
        }
    }
    
    func addFriend(completionHandler: @escaping (_ finished: Bool) -> Void){
        var userDF = UserDefaults.standard
        var recordFriendID = CKRecord.ID(recordName: selectedNotification!)
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        var recordFriends = CKRecord(recordType: RemoteRecords.friends)
        
        recordFriends[RemoteFriends.friendId] = CKRecord.Reference(recordID: recordFriendID, action: .deleteSelf)
        recordFriends[RemoteFriends.userId] = CKRecord.Reference(recordID: recordUserID, action: .deleteSelf)
        recordFriends[RemoteFriends.status] = "Follow" as! NSString
        DBConnection.share.publicDB.save(recordFriends) { (record, error) in
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

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Notification Cell") as! NotificationTableViewCell
        let notifDetail = notificationDetail[indexPath.row]
        let notif = notificationList[indexPath.row]
//        cell.ivUserImage.image = #imageLiteral(resourceName: "human")
        cell.lblName.text = notifDetail[RemoteNotifications.type] as! String
        cell.lblLastActive.text = "10 minutes ago"
        //cell.setCell(model: notifList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn()
        let notifDetail = notificationDetail[indexPath.row]
        let notif = notificationList[indexPath.row]
        
        if let asset = notif[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.ivEventPhoto.image = UIImage(data: data)
            }
        }
        
        
        let friendGoalID = notif.recordID.recordName
        selectedNotification = friendGoalID
        lblEventName.text = notif[RemoteUsers.name] as! String
        lblEventDateAndTime.text = selectedNotification
        lblEventLocation.text = notif[RemoteUsers.location]
    }
    
    
    
}
