//
//  LoginPageController.swift
//  MC3 Volunteering
//
//  Created by Monica Khoe on 21/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class LoginPageController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    var userDef = UserDefaults.standard
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        let email = userDef.string(forKey: "email")
        label.text = email
        
        _ = userDef.string(forKey: "password")
        
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
        userDef.set(emailTF.text, forKey: "email")
        label.text = emailTF.text
        label2.text = passwordTF.text
        
    }
    
    
}
