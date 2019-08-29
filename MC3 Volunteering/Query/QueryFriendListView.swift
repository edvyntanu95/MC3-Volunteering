//
//  QueryFriendListView.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

class QueryFriendListView{
    
//    func getFriendList(completionHandler: @escaping (_ finished: Bool) -> Void){
//
//        let userDF = UserDefaults.standard
//        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
//        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
//        let predicate = NSPredicate(format: "recordUserID == %@", userReference)
//        let query = CKQuery(recordType: RemoteRecords.friends, predicate: predicate)
//
//
//        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }else{
//                guard let records = records else {return}
//                var recordNames:[CKRecord.ID] = []
//                for record in records {
//                    let friendReference = record[RemoteFriends.id] as! CKRecord.Reference
//                    self.friends.append(record)
//                    recordNames.append(friendReference.recordID)
//                }
//
//                print(recordNames.count)
//
//                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
//                operation.fetchRecordsCompletionBlock = { (records, error) in
//                    guard let records = records else {return}
//                    for (key, value) in records {
//                        self.friendList.append(value)
//                    }
//                    completionHandler(true)
//                }
//                DBConnection.share.publicDB.add(operation)
//
//            }
//        }
//    }
    
}
