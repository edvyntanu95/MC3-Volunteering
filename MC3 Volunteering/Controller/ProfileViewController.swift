//
//  ProfileViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UIViewController {
    
    var userData:[CKRecord] = []
    var userCetificates:[CKRecord] = []
    
    
    @IBOutlet weak var certificateCV: UICollectionView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblBioDescription: UILabel!
    
    @IBOutlet weak var certificateView: UIImageView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet var popUpView: UIView!
    
//    var user = UserModel.init(userID: "001", userName: "prahadiM", userPass: "12345", userEmail: "prahadiM@gmail.com", userPhoto: #imageLiteral(resourceName: "human"), userRole: "User", userLocation: "Tangerang", userBioDesc: "I am a diligent student who likes to code and jokes around with my friends and have a good time with everybody and anybody :)", userCertificates: [#imageLiteral(resourceName: "village"),#imageLiteral(resourceName: "Motor"),#imageLiteral(resourceName: "village2")])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserData { (finished) in
            self.getUserCertificate(completionHandler: { (finished) in
                if finished == true {
                    self.setUpContent()
                }
            })
        }
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapped))
        
        visualEffectView.addGestureRecognizer(tap2)
        popUpView.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        visualEffectView.isHidden = true
    }
    
    func setUpContent(){
        let user = self.userData[0]
        DispatchQueue.main.async {
            if let asset = user[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
            {
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: data)
                }
            }
            self.lblName.text = user[RemoteUsers.name] as! String
            self.lblLocation.text = user[RemoteUsers.location] as! String
            self.lblBioDescription.text = user[RemoteUsers.userBio] as! String
            self.certificateCV.reloadData()
        }
    }
    
    func animateIn(){
        self.view.addSubview(popUpView)
        
        popUpView.center = self.view.center
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        
        
        tabBarController?.tabBar.alpha = 0.5
        tabBarController?.tabBar.isUserInteractionEnabled = false
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
    
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut(){
        
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        self.navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            self.popUpView.alpha = 0
            self.visualEffectView.isHidden = true
            self.tabBarController?.tabBar.alpha = 1.0
        }) { (success: Bool) in
            self.popUpView.removeFromSuperview()
            
        }
    }
    
    @objc func userDidTapped(tap : UITapGestureRecognizer){
        if self.popUpView.alpha == 1 {
            animateOut()
        }
    }

    @IBAction func qrCodeButtonTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController
        let user = userData[0]
        vc?.userName = user[RemoteUsers.name] as! String
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingProfileViewController") as? SettingProfileViewController
        let user = userData[0]
        vc?.name = user[RemoteUsers.name] as! String
        vc?.location = user[RemoteUsers.location] as! String
        vc?.passion = user[RemoteUsers.userBio] as! String
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func getUserCertificate(completionHandler: @escaping (_ finished: Bool) -> Void) {
        let userID = CKRecord.ID(recordName: UserDefaults.standard.string(forKey: "sessionID")!)
        let predicate = NSPredicate(format: "recordID == %@", userID)
        let query = CKQuery(recordType: RemoteRecords.certificates, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                guard let records = records else {return}
                for record in records {
                    self.userCetificates.append(record)
                }
                completionHandler(true)
            }
        }
    }
    
    func getUserData(completionHandler: @escaping (_ finished: Bool) -> Void) {
        let userID = CKRecord.ID(recordName: UserDefaults.standard.string(forKey: "sessionID")!)
        let predicate = NSPredicate(format: "recordID == %@", userID)
        let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(false)
            }else{
                guard let records = records else {return}
                for record in records {
                    self.userData.append(record)
                }
                completionHandler(true)
            }
        }
    }
    

    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCetificates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certificatesCell", for: indexPath) as! ECertificateCollectionViewCell
        let certificate = userCetificates[indexPath.row]
        cell.setCell(certificate: certificate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animateIn()
        let certificate = userCetificates[indexPath.row]
        if let asset = certificate[RemoteCertificates.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.certificateView.image = UIImage(data: data)
            }
        }
    }
    
    
}
