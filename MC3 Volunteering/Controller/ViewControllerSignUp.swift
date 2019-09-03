//
//  ViewControllerSignUp.swift
//  LoginPage
//
//  Created by Monica Khoe on 21/08/19.
//  Copyright © 2019 Monica Khoe. All rights reserved.
//

import UIKit

class ViewControllerSignUp: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var userNameTF: UITextField!
    
    
//    @IBOutlet weak var label1: UILabel!
//    
//    @IBOutlet weak var label2: UILabel!
    
    
    var userDef = UserDefaults.standard
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // left icon setting 
        nameTF.setLeftImageSup(imageName: "icons8-identification-documents-50")
        emailTF.setLeftImageSup(imageName: "icons8-email-sign-50")
        passwordTF.setLeftImageSup(imageName: "icons8-lock-50")
        userNameTF.setLeftImageSup(imageName: "icons8-male-user-50")

        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        _ = userDef.string(forKey: "email")
        
        _ = userDef.string(forKey: "name")
        
        _ = userDef.string(forKey: "password")
        
        signUpButton.layer.cornerRadius = 20
        signUpButton.layer.masksToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        userDef.set(emailTF.text, forKey: "email")
//        label1.text = emailTF.text
//        label2.text = passwordTF.text
    }
    
    @IBAction func closeButtonSignUpPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}

extension UITextField {
    func setLeftImageSup(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
    }
}
