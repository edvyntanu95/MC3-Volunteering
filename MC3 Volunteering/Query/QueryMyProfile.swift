//
//  QueryMyProfile.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

//func getUserData(completionHandler: @escaping (_ finished: Bool) -> Void) {
//    let userID = CKRecord.ID(recordName: UserDefaults.standard.string(forKey: "sessionID")!)
//    let predicate = NSPredicate(format: "recordID == %@", userID)
//    let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
//    let queryOperation = CKQueryOperation(query: query)
//    DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            guard let records = records else {return}
//            let record = records.first
//            self.name = record![RemoteUsers.name] as! String
//            if let asset = record![RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
//            {
//                self.photo = UIImage(data: data)
//            }
//            completionHandler(true)
//        }
//    }
//}
