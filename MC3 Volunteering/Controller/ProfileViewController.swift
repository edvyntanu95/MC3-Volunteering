//
//  ProfileViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 26/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblBioDescription: UILabel!
    
    @IBOutlet weak var certificateView: UIImageView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    @IBOutlet var popUpView: UIView!
    
    var user = UserModel.init(userID: "001", userName: "prahadiM", userPass: "12345", userEmail: "prahadiM@gmail.com", userPhoto: #imageLiteral(resourceName: "human"), userRole: "User", userLocation: "Tangerang", userBioDesc: "I am a diligent student who likes to code and jokes around with my friends and have a good time with everybody and anybody :)", userCertificates: [#imageLiteral(resourceName: "village"),#imageLiteral(resourceName: "Motor"),#imageLiteral(resourceName: "village2")])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.userDidTapped))
        
        visualEffectView.addGestureRecognizer(tap2)
        popUpView.addGestureRecognizer(tap)
        setUpContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        visualEffectView.isHidden = true
    }
    
    func setUpContent(){
        profileImageView.image = user.userPhoto
        lblName.text = user.userName
        lblLocation.text = user.userLocation
        lblBioDescription.text = user.userBioDesc
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
    @IBAction func qrCodeButtonTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController
        
        vc?.userName = user.userName
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.userCertificates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "certificatesCell", for: indexPath) as! ECertificateCollectionViewCell
        cell.setCell(model: user, row: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animateIn()
        certificateView.image = user.userCertificates[indexPath.row]
    }
    
    
}
