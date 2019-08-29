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
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye"), for: .normal)
        button.frame = CGRect(x: CGFloat(passwordTF.frame.size.width - 30), y: CGFloat(5), width: CGFloat(25), height: CGFloat(15))
        button.addTarget(self, action: #selector(self.refresh), for: .touchDown)
        passwordTF.rightView = button
        passwordTF.rightViewMode = .always
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
        login { (finished) in
            if(finished == true) {
                print("Benar")
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
