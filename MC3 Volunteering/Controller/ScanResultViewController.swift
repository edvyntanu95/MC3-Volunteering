//
//  ScanResultViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class ScanResultViewController: UIViewController {
    var scanResult:String?
    var user:[CKRecord] = []
    @IBOutlet weak var ivPersonImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 20
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    @IBOutlet weak var lblNickName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator("Please Wait..")
        print(scanResult)
        DispatchQueue.global().async {
            self.getScannerResult(completionHandler: { (finished) in
                if finished {
                    DispatchQueue.main.async {
                        self.effectView.removeFromSuperview()
                        self.setUpPage()
                    }
                }
            })
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func addFriendTapped(_ sender: UIButton) {
        activityIndicator("Please Wait..")
        DispatchQueue.global().async {
            self.addFriend { (finished) in
                if finished {
                    self.sendNotification(completionHandler: { (finished) in
                        if finished {
                            DispatchQueue.main.async {
                                self.effectView.removeFromSuperview()
                                print("Berhasil Tambah Teman")
                            }
                        }
                    })
                }
            }
        }
    }
    
    func setUpPage(){
        ivPersonImage.layer.cornerRadius = ivPersonImage.frame.height / 2
        ivPersonImage.layer.masksToBounds = true
        addFriendButton.layer.cornerRadius = 20
        addFriendButton.layer.borderColor = #colorLiteral(red: 0.08758807927, green: 0.5526862144, blue: 0.8551954627, alpha: 1)
        addFriendButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addFriendButton.layer.borderWidth = 0.5
        viewBackground.backgroundColor = #colorLiteral(red: 0.08758807927, green: 0.5526862144, blue: 0.8551954627, alpha: 1)
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.masksToBounds = true
        let userSpecific = user[0]
        lblLocation.text = userSpecific[RemoteUsers.location]
        lblName.text = userSpecific[RemoteUsers.name]
        if let asset = userSpecific[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.ivPersonImage.image = UIImage(data: data)
            }
        }
    }
    
    func getScannerResult(completionHandler: @escaping (_ finished: Bool) -> Void){
        var recordFriendID = CKRecord.ID(recordName: scanResult!)
        let predicate = NSPredicate(format: "recordID == %@", recordFriendID)
        let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
        
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                for record in records {
                    self.user.append(record)
                }
                completionHandler(true)
            }
        }
    }
    
    func addFriend(completionHandler: @escaping (_ finished: Bool) -> Void){
        var userDF = UserDefaults.standard
        var recordFriendID = CKRecord.ID(recordName: scanResult!)
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        var recordFriends = CKRecord(recordType: RemoteRecords.friends)
        
        recordFriends[RemoteFriends.friendId] = CKRecord.Reference(recordID: recordFriendID, action: .deleteSelf)
        recordFriends[RemoteFriends.userId] = CKRecord.Reference(recordID: recordUserID, action: .deleteSelf)
        recordFriends[RemoteFriends.status] = "Follow" as! NSString
        DBConnection.share.publicDB.save(recordFriends) { (record, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                print(record)
                completionHandler(true)
            }
        }
    }
    
    func sendNotification(completionHandler: @escaping(_ finished: Bool) -> Void){
        var userDF = UserDefaults.standard
        var recordReceiver = CKRecord.ID(recordName: scanResult!)
        var recordSender = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        var recordNotification = CKRecord(recordType: RemoteRecords.notifications)
        
        recordNotification[RemoteNotifications.senderID] = CKRecord.Reference(recordID: recordSender, action: .deleteSelf)
        recordNotification[RemoteNotifications.receiverID] = CKRecord.Reference(recordID: recordReceiver, action: .deleteSelf)
        recordNotification[RemoteNotifications.type] = "Friend Invitation"
        
        DBConnection.share.publicDB.save(recordNotification) { (record, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                print(record)
                completionHandler(true)
            }
        }
        
    }
    
    
    

}
