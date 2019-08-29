//
//  QueryRegisterEventAlone.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

//func joinEvent(completionHandler: @escaping (_ finished: Bool) -> Void){
//    var recordEventID = CKRecord.ID(recordName: eventId!)
//    var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
//    var recordRegisterEvent = CKRecord(recordType: RemoteRecords.registerEvents)
//    
//    print("Record ID EVENT : \(recordEventID)")
//    print("Record ID USER : \(recordUserID)")
//    completionHandler(true)
//    
//    recordRegisterEvent[RemoteRegisterEvents.eventId] = CKRecord.Reference(recordID: recordEventID, action: .none)
//    recordRegisterEvent[RemoteRegisterEvents.userId] = CKRecord.Reference(recordID: recordUserID, action: .none)
//    recordRegisterEvent[RemoteRegisterEvents.status] = "Registered" as! NSString
//    DBConnection.share.publicDB.save(recordRegisterEvent) { (record, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            completionHandler(true)
//        }
//    }
//}
