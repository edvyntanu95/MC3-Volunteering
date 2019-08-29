//
//  QueryAddFriend.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

//class QueryAddFriend{
//    func addFriend(completionHandler: @escaping (_ finished: Bool) -> Void){
//        var recordFriendID = CKRecord.ID(recordName: RemoteFriends.id)
//        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
//        var recordAddFriend = CKRecord(recordType: RemoteRecords.friends)
//    
//        print("Record ID EVENT : \(recordEventID)")
//        print("Record ID USER : \(recordUserID)")
//        completionHandler(true)
//    
//        recordAddFriend[RemoteFriends.friendId] = CKRecord.Reference(recordID: recordFriendID, action: .none)
//        recordAddFriend[RemoteRegisterEvents.userId] = CKRecord.Reference(recordID: recordUserID, action: .none)
//        recordAddFriend[RemoteRegisterEvents.status] = "Registered" as! NSString
//        DBConnection.share.publicDB.save(recordAddFriend) { (record, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }else{
//                completionHandler(true)
//            }
//        }
//    }
//}
