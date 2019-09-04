//
//  MyActivitiesPage.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class MyActivitiesPage: UIViewController {
    
    var myActivitiesEventList:[CKRecord] = []
    var myActivitiesEventsListStatus:[CKRecord] = []
    
    var recordFriendEvent:[CKRecord.ID] = []
    var recordFriends:[CKRecord.ID] = []
    
    var myActivitiesFriendEventList:[CKRecord] = []
    var myActivitiesFriendEventsListStatus:[CKRecord] = []
    var myActivitiesFriend: [CKRecord] = []
    
    var currentMyActivitiesEventList:[CKRecord] = []
    var currentMyActivitiesEventsListStatus:[CKRecord] = []
    
    @IBOutlet weak var myActivitiesCV: UICollectionView!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var segmentType : String = ""
    
    // segmented control functions
    @IBAction func segmentedControlSwitched(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            safe = false
            segmentType = "Alone"
            let userDEF = UserDefaults.standard
            userDEF.synchronize()
            if !userDEF.bool(forKey: "isLogin") {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginPageController")
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                activityIndicator("Please wait...")
                currentMyActivitiesEventList = []
                currentMyActivitiesEventsListStatus = []
                myActivitiesEventList = []
                myActivitiesEventsListStatus = []
                DispatchQueue.global().async {
                    self.getMyActivitiesEventList { (finished) in
                        DispatchQueue.main.async {
                            for activities in self.myActivitiesEventList {
                                self.currentMyActivitiesEventList.append(activities)
                            }
                            
                            for status in self.myActivitiesEventsListStatus {
                                self.currentMyActivitiesEventsListStatus.append(status)
                            }
                    
                            self.effectView.removeFromSuperview()
                            self.myActivitiesCV.reloadData()
                            self.safe = true
                        }
                    }
                }
            }
            // statusArray = array alone event status
            // currentArray = array alone event
        } else {
            safe = false
            segmentType = "Friends"
            let userDEF = UserDefaults.standard
            userDEF.synchronize()
            if !userDEF.bool(forKey: "isLogin") {
                let vc = storyboard?.instantiateViewController(withIdentifier: "LoginPageController")
                self.navigationController?.pushViewController(vc!, animated: true)
            } else {
                activityIndicator("Please wait...")
                currentMyActivitiesEventList = []
                currentMyActivitiesEventsListStatus = []
                myActivitiesFriendEventList = []
                myActivitiesFriendEventsListStatus = []
                myActivitiesFriend = []
                DispatchQueue.global().async {
                    self.getMyActivitiesFriendEventList { (finished) in
                        DispatchQueue.main.async {
                            print("Event Bersama Teman \(self.myActivitiesFriendEventList.count)")
                            print("Status Event Bersama Teman \(self.myActivitiesFriendEventsListStatus.count)")
                            print("Jumlah Teman Event Bersama Teman \(self.myActivitiesFriend.count)")
                            for activities in self.myActivitiesFriendEventList {
                                self.currentMyActivitiesEventList.append(activities)
                            }
                            
                            for status in self.myActivitiesFriendEventsListStatus {
                                self.currentMyActivitiesEventsListStatus.append(status)
                            }
                            self.effectView.removeFromSuperview()
                            self.myActivitiesCV.reloadData()
                            self.safe = true
                        }
                    }
                }
            }
            // currentArray = array with friends
        }
    }
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 20
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getMyActivitiesEventList { (finished) in
//            DispatchQueue.main.async {
//                self.myActivitiesCV.reloadData()
//            }
//        }
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.08758807927, green: 0.5526862144, blue: 0.8551954627, alpha: 1)
    }
    
    var safe: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func getMyActivitiesEventList(completionHandler: @escaping (_ finished: Bool) -> Void){
    
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        
        let predicate = NSPredicate(format: "recordUserID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.registerEvents, predicate: predicate)
    
    
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                
                var recordNames:[CKRecord.ID] = []
                
                for record in records {
                    let eventReference = record[RemoteRegisterEvents.eventId] as! CKRecord.Reference
                    self.myActivitiesEventsListStatus.append(record)
                    recordNames.append(eventReference.recordID)
                }
    
                print(recordNames.count)
    
                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
                operation.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.myActivitiesEventList.append(value)
                    }
                    completionHandler(true)
                }
                DBConnection.share.publicDB.add(operation)
            }
        }
    }
    
    
    func getMyActivitiesFriendEventList(completionHandler: @escaping (_ finished: Bool) -> Void){
        
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        let predicate = NSPredicate(format: "recordUserID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.inviteEvents, predicate: predicate)
        
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                
                for record in records {
                    let eventReference = record[RemoteInviteEvents.eventId] as! CKRecord.Reference
                    let friendReference = record[RemoteInviteEvents.friendId] as! CKRecord.Reference
                    self.myActivitiesFriendEventsListStatus.append(record)
                    self.recordFriends.append(friendReference.recordID)
                    self.recordFriendEvent.append(eventReference.recordID)
                }
                
                let operation1 = CKFetchRecordsOperation(recordIDs: self.recordFriendEvent)
                operation1.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.myActivitiesFriendEventList.append(value)
                    }
                    
                    let operation2 = CKFetchRecordsOperation(recordIDs: self.recordFriends)
                    operation2.fetchRecordsCompletionBlock = { (records, error) in
                        guard let records = records else {return}
                        for (key, value) in records {
                            self.myActivitiesFriend.append(value)
                        }
                        
                        completionHandler(true)
                    }
                    DBConnection.share.publicDB.add(operation2)
                    
                }
        
                DBConnection.share.publicDB.add(operation1)
                
                
                
            }
        }
    }
    
    
            
}

extension MyActivitiesPage:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMyActivitiesEventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCollectionViewCell", for: indexPath) as! ActivitiesCollectionViewCell
        if safe == true {
            let myActivity = currentMyActivitiesEventList[indexPath.row]
            let myActivityStatus = currentMyActivitiesEventsListStatus[indexPath.row]
            cell.setCell(myActivity: myActivity, myActivityStatus: myActivityStatus)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if safe == true{
            if segmentType == "Alone" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyActivitiesDetailsPage") as? MyActivitiesDetailsPage
                let myActivity = currentMyActivitiesEventList[indexPath.row]
                let myActivityStatus = currentMyActivitiesEventsListStatus[indexPath.row]
                
                let eventRecordID = myActivity.recordID.recordName
                vc?.eventId = eventRecordID
                vc?.eventTitle = myActivity[RemoteEvents.name] as! String
                vc?.eventDescriptions = myActivity[RemoteEvents.description] as! String
                vc?.eventLocation = myActivity[RemoteEvents.location] as! String
                vc?.eventTime = myActivity[RemoteEvents.time] as! String
                vc?.eventDate = myActivity[RemoteEvents.date] as! String
                vc?.eventOrganizer = myActivity[RemoteEvents.organizer] as! String
                vc?.eventStatus = myActivityStatus[RemoteRegisterEvents.status] as! String
                
                if let asset = myActivity[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
                {
                    vc?.eventImage = UIImage(data: data)
                }
                self.navigationController?.pushViewController(vc!, animated: true)
                
            } else if segmentType == "Friends" {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailEventWithFriendsController") as? DetailEventWithFriendsController
                    let myActivity = currentMyActivitiesEventList[indexPath.row]
                    let myActivityStatus = currentMyActivitiesEventsListStatus[indexPath.row]
                    
                    let eventRecordID = myActivity.recordID.recordName
                    vc?.eventId = eventRecordID
                    vc?.eventTitle = myActivity[RemoteEvents.name] as! String
                    vc?.eventDescription = myActivity[RemoteEvents.description] as! String
                    vc?.eventLocation = myActivity[RemoteEvents.location] as! String
                    vc?.eventTime = myActivity[RemoteEvents.time] as! String
                    vc?.eventDate = myActivity[RemoteEvents.date] as! String
                    vc?.eventOrganizer = myActivity[RemoteEvents.organizer] as! String
                    vc?.eventStatus = myActivityStatus[RemoteRegisterEvents.status] as! String
                
                for friend in myActivitiesFriend {
                    vc?.friend.append(friend)
                }
                    
                    if let asset = myActivity[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
                    {
                        vc?.imageEvent = UIImage(data: data)
                    }
                    self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
            
    }
    
}
