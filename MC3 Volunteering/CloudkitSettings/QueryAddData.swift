//
//  QueryAddData.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit


//REGISTER AKUN
//func addUsersRecordType(name:String, username: String, password: String, email: String){
//
//    let predicate = NSPredicate(format: "\(RemoteUser.email) == %@", emailTF.text!)
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
//                record[RemoteUser.name] = name as NSString
//                record[RemoteUser.username] = username as NSString
//                record[RemoteUser.email] = email as NSString
//                record[RemoteUser.password] = password as NSString
//                if let imageURL = Bundle.main.url(forResource: "teachFormal", withExtension: "jpg") {
//                    let ckAsset = CKAsset(fileURL: imageURL)
//                    record[RemoteUser.photo] = ckAsset
//                }
//
//                DBConnection.share.publicDB.save(record) { (record, error) in
//                    if error != nil {
//                        print(error!.localizedDescription)
//                    }else{
//                        print("Record Type \(RemoteRecords.users) Berhasil Di Buat")
//                    }
//                }
//            }
//        }
//    }
//}


//ADD DATA EVENT
//func addDataEvent() {
//    let record = CKRecord(recordType: RemoteRecords.events)
//    record[RemoteEvents.name] = "Mengajar Menari" as NSString
//    record[RemoteEvents.description] = "Mengajak Anak Belajar Bersama Social Menari" as NSString
//    record[RemoteEvents.location] = "Kota Kudus" as NSString
//    record[RemoteEvents.date] = "21 August 2019" as NSString
//    if let imageURL = Bundle.main.url(forResource: "teachDrawing", withExtension: "jpg") {
//        let ckAsset = CKAsset(fileURL: imageURL)
//        record[RemoteEvents.photo] = ckAsset
//    }
//    record[RemoteEvents.fee] = NSNumber(value: 80.000)
//
//    DBConnection.share.publicDB.save(record) { (record, error) in
//        if error != nil {
//            print(error!.localizedDescription)
//        }else{
//            print("Record Type \(RemoteRecords.events) Berhasil Di Buat")
//        }
//    }
//}




