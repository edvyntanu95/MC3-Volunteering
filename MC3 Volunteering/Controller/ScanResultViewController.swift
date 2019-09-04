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
    
    @IBOutlet weak var lblNickName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(scanResult)
        DispatchQueue.global().async {
            self.getScannerResult(completionHandler: { (finished) in
                if finished {
                    DispatchQueue.main.async {
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
        var recordUserID = scanResult
        let predicate = NSPredicate(format: "\(RemoteUsers.username) == %@", recordUserID!)
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
    

}
