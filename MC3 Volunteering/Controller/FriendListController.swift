//
//  FriendListController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class FriendListController: UIViewController{
    @IBOutlet weak var myFriendListTV: UITableView!
    
    var eventId = ""
    var friendId = [String]()
    
    var myFriends : [CKRecord] = []
    
    var friendArray : [FriendModel] = []
    
    func makeFriendArrayObject() -> [FriendModel] {
        var tempArray : [FriendModel] = []
        
        let model1  = FriendModel.init(friendID: "001", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Hadi", lastActive: "5 minutes ago")
        
        let model2 = FriendModel.init(friendID: "002", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Edvyn", lastActive: "10 minutes ago")
        
        let model3 = FriendModel.init(friendID: "003", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Ben", lastActive: "15 minutes ago")
        
        let model4 = FriendModel.init(friendID: "004", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Monic", lastActive: "20 minutes ago")
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        tempArray.append(model4)
        
        return tempArray
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableViewCell: ClickableTableViewCell!
    
    override func viewWillAppear(_ animated: Bool) {
        print("Event ID ini : \(eventId)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyFriendList { (finished) in
            if finished == true {
                print("Friend List Berhasil Di Load")
                for friend in self.myFriends {
                    print(friend)
                }
                
                DispatchQueue.main.async {
                    self.myFriendListTV.reloadData()
                }
                
            }
        }
    }
    
    
    
    @IBAction func inviteButtonFriendList(_ sender: Any) {
        inviteFriendToEvent { (finished) in
            print("Invite Button Tapped")
            for friend in self.friendId {
                print(friend)
            }
        }
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performSegue(withIdentifier: "selectPreferenceRole", sender: nil)
    }
    
    func getMyFriendList(completionHandler: @escaping (_ finished: Bool) -> Void){
        
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        let predicate = NSPredicate(format: "userID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.friends, predicate: predicate)
        
        
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                var recordNames:[CKRecord.ID] = []
                for record in records {
                    let friendReference = record[RemoteFriends.friendId] as! CKRecord.Reference
                    recordNames.append(friendReference.recordID)
                }
                
                print(recordNames.count)
                
                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
                operation.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.myFriends.append(value)
                    }
                    completionHandler(true)
                }
                DBConnection.share.publicDB.add(operation)
            }
        }
    }
    
    func inviteFriendToEvent(completionHandler:@escaping(_ finished: Bool) -> Void){
        for friend in friendId {
            var userDF = UserDefaults.standard
            var recordEventID = CKRecord.ID(recordName: eventId)
            var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
            var recordFriendID = CKRecord.ID(recordName: friend)
            var recordInviteEvent = CKRecord(recordType: RemoteRecords.inviteEvents)
            
            print("Record ID EVENT : \(recordEventID)")
            print("Record ID USER : \(recordUserID)")
            print("Record ID FRIEND : \(recordFriendID)")
            
            recordInviteEvent[RemoteInviteEvents.eventId] = CKRecord.Reference(recordID: recordEventID, action: .deleteSelf)
            recordInviteEvent[RemoteInviteEvents.userId] = CKRecord.Reference(recordID: recordUserID, action: .deleteSelf)
            recordInviteEvent[RemoteInviteEvents.friendId] = CKRecord.Reference(recordID: recordFriendID, action: .deleteSelf)
            recordInviteEvent[RemoteInviteEvents.status] = "Pending" as! NSString
            DBConnection.share.publicDB.save(recordInviteEvent) { (record, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    completionHandler(false)
                }else{
                    print("RECORD BERHASIL DI TAMBAH \(friend)")
                }
            }
        }
        completionHandler(true)
    }
    
}

extension FriendListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! ClickableTableViewCell
        var friend = myFriends[indexPath.row]
        cell.setInviteYourFriends(model: friend)
        
        return cell
    }
    
    func checkableTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as? ClickableTableViewCell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var friend = myFriends[indexPath.row]
        friendId.append(friend.recordID.recordName)
    }
}
