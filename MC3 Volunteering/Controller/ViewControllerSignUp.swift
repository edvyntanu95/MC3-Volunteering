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
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    
    var userDef = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        _ = userDef.string(forKey: "email")
        
        _ = userDef.string(forKey: "name")
        
        _ = userDef.string(forKey: "password")
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
        label1.text = emailTF.text
        label2.text = passwordTF.text
    }
    
    @IBAction func closeButtonSignUpPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
