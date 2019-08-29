//
//  InitDataViewController.swift
//  MC3 Volunteering
//
//  Created by Pramahadi Tama Putra on 29/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class InitDataViewController: UIViewController {
    
    var myString = "test"
    var processedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        register { (finished) in
            if finished == true {
                print("Tambah Akun Berhasil")
            }else {
                print("Tambah Akun Gagal")
            }
        }
    }
    
    //CREATE BARCODE
    func createBarcode(completionHandler:@escaping(_ finished: Bool) -> Void) {
        // Get data from the string
        let data = myString.data(using: String.Encoding.ascii)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return }
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return }
        processedImage = UIImage(cgImage: cgImage)
        completionHandler(true)
    }
    
    
    //ADD EVENT
    func addDataEvent(completionHandler:@escaping(_ finished: Bool) -> Void ) {
        let record = CKRecord(recordType: RemoteRecords.events)
        record[RemoteEvents.name] = "Mengajar Menari Part 5" as NSString
        record[RemoteEvents.description] = "Mengajak Anak Belajar Bersama Social Menari Part 5" as NSString
        record[RemoteEvents.location] = "Kota Kudus" as NSString
        record[RemoteEvents.date] = "27 August 2019" as NSString
        record[RemoteEvents.organizer] = "Social Designee" as NSString
        record[RemoteEvents.time] = "19.00" as NSString
        if let imageURL = Bundle.main.url(forResource: "gambar1", withExtension: "jpg") {
            let ckAsset = CKAsset(fileURL: imageURL)
            record[RemoteEvents.photo] = ckAsset
        }
        
        DBConnection.share.publicDB.save(record) { (record, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                print("Record Type \(RemoteRecords.events) Berhasil Di Buat")
                completionHandler(true)
            }
        }
    }
    
    //    REGISTER AKUN
    func register(completionHandler: @escaping(_ finished: Bool) -> Void){
        let record = CKRecord(recordType: RemoteRecords.users)
        record[RemoteUsers.name] = "Pramahadi Tama Putra" as NSString
        record[RemoteUsers.username] = "test" as NSString
        record[RemoteUsers.email] = "test@test.com" as NSString
        record[RemoteUsers.password] = "test123" as NSString
        record[RemoteUsers.userRole] = "Volunteer"
        record[RemoteUsers.location] = "Kota Tangerang" as NSString
        if let imageURL = Bundle.main.url(forResource: "belajar1", withExtension: "jpg") {
            let ckAsset = CKAsset(fileURL: imageURL)
            record[RemoteUsers.photo] = ckAsset
        }
        
        DBConnection.share.publicDB.save(record) { (record, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                print("Akun \(RemoteRecords.users) Berhasil Di Buat")
                completionHandler(true)
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

