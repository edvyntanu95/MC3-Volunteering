//
//  QueryAddEvent.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import Foundation
import CloudKit

//ADD DATA EVENT
//func addDataEvent() {
//    let record = CKRecord(recordType: RemoteRecords.events)
//    
//    record[RemoteEvents.name] = "Mengajar Menari Part 3" as NSString
//    record[RemoteEvents.description] = "Mengajak Anak Belajar Bersama Social Menari" as NSString
//    record[RemoteEvents.location] = "Kota Kudus" as NSString
//    record[RemoteEvents.date] = "23 August 2019" as NSString
//    record[RemoteEvents.organizer] = "Social Designee" as NSString
//    record[RemoteEvents.time] = "19.00" as NSString
//    if let imageURL = Bundle.main.url(forResource: "gambar1", withExtension: "jpg") {
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
