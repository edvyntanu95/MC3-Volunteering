//
//  QueryRegister.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit


//REGISTER AKUN
//func register(name:String, username: String, password: String, email: String){
//    
//    let predicate = NSPredicate(format: "\(RemoteUsers.email) == %@", emailTF.text!)
//    let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
//    
//    DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            guard let records = records else {return}
//            if records.count > 0 {
//                print("Akun Sudah Pernah Di Buat")
//            }else{
//                let record = CKRecord(recordType: RemoteRecords.users)
//                record[RemoteUsers.name] = name as NSString
//                record[RemoteUsers.username] = username as NSString
//                record[RemoteUsers.email] = email as NSString
//                record[RemoteUsers.password] = password as NSString
//                if let imageURL = Bundle.main.url(forResource: "belajar1", withExtension: "jpg") {
//                    let ckAsset = CKAsset(fileURL: imageURL)
//                    record[RemoteUsers.photo] = ckAsset
//                }
//                
//                DBConnection.share.publicDB.save(record) { (record, error) in
//                    if error != nil {
//                        print(error!.localizedDescription)
//                    }else{
//                        print("Akun \(RemoteRecords.users) Berhasil Di Buat")
//                    }
//                }
//            }
//        }
//    }
//}
