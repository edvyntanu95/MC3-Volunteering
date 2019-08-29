//
//  QueryMyActivities.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

//func getRegisterEventList(completionHandler: @escaping (_ finished: Bool) -> Void){
//    
//    let userDF = UserDefaults.standard
//    var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
//    let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
//    let predicate = NSPredicate(format: "recordUserID == %@", userReference)
//    let query = CKQuery(recordType: RemoteRecords.registerEvents, predicate: predicate)
//    
//    
//    DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            guard let records = records else {return}
//            var recordNames:[CKRecord.ID] = []
//            for record in records {
//                let eventReference = record[RemoteRegisterEvents.eventId] as! CKRecord.Reference
//                self.eventStatusList.append(record)
//                recordNames.append(eventReference.recordID)
//            }
//            
//            print(recordNames.count)
//            
//            let operation = CKFetchRecordsOperation(recordIDs: recordNames)
//            operation.fetchRecordsCompletionBlock = { (records, error) in
//                guard let records = records else {return}
//                for (key, value) in records {
//                    self.registerEventList.append(value)
//                }
//                completionHandler(true)
//            }
//            DBConnection.share.publicDB.add(operation)
//            
//        }
//}
