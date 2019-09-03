//
//  LoginPageController.swift
//  MC3 Volunteering
//
//  Created by Monica Khoe on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class LoginPageController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var userDef = UserDefaults.standard
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //icon kiri untuk txtField
        emailTF.setLeftImageLogin(imageName: "icons8-email-sign-50")
        passwordTF.setLeftImageLogin(imageName: "icons8-lock-50")
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        signInButton.layer.cornerRadius = 20
        signInButton.layer.masksToBounds = true
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(15))
        button.addTarget(self, action: #selector(self.refresh), for: .touchDown)
        passwordTF.rightView = button
        passwordTF.rightViewMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDEF = UserDefaults.standard
        userDEF.synchronize()
        if userDEF.bool(forKey: "isLogin") {
            self.navigationController?.popViewController(animated: true)
        }
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTF{
            passwordTF.becomeFirstResponder()
        }else if textField == passwordTF{
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func refresh( sender: Any){
        passwordTF.isSecureTextEntry.toggle()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
            self.login { (finished) in
                if(finished == true) {
                    print("Benar")
                    self.userDef.synchronize()
                    DispatchQueue.main.async {
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
//                        self.navigationController?.pushViewController(vc!, animated: true)
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }else{
                    print("Salah")
                }
            }
    }
    
    func login(completionhandler:@escaping(_ finished:Bool) -> Void) {
        var userDF = UserDefaults.standard
        var isLogin = userDF.bool(forKey: "isLogin")
        var sessionID = userDF.string(forKey: "sessionID")
        let predicate = NSPredicate(format: "\(RemoteUsers.email) == %@ && \(RemoteUsers.password ) == %@", emailTF.text!, passwordTF.text!)
        let query = CKQuery(recordType: RemoteRecords.users, predicate: predicate)
    
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                if records.count > 0 {
                    userDF.set(true, forKey: "isLogin")
                    for record in records {
                        userDF.set(record.recordID.recordName as! String, forKey: "sessionID")
                    }
                    completionhandler(true)
                }else{
                    print("Akun Belom Daftar / Salah Input")
                    completionhandler(false)
                }
            }
        }
    }
    
    
}


extension UITextField {
    func setLeftImageLogin(imageName: String) {
        
        let imageView = UIImageView(frame: CGRect(x: 30, y: 0, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
        
    }
    
}
