//
//  QueryLogin.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation

//func login(completionhandler:@escaping(_ finished:Bool) -> Void) {
//    var userDF = UserDefaults.standard
//    var isLogin = userDF.bool(forKey: "isLogin")
//    var sessionID = userDF.string(forKey: "sessionID")
//    let predicate = NSPredicate(format: "\(RemoteUsers.email) == %@ && \(RemoteUsers.password ) == %@", emailTF.text!, passwordTF.text!)
//    let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
//
//    DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            guard let records = records else {return}
//            if records.count > 0 {
//                userDF.set(true, forKey: "isLogin")
//                for record in records {
//                    userDF.set(record.recordID.recordName as! String, forKey: "sessionID")
//                }
//            }else{
//                print("Akun Belom Daftar / Salah Input")
//            }
//        }
//        completionhandler(true)
//    }
//}
