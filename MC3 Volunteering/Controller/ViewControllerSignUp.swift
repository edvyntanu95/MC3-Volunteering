//
//  ViewControllerSignUp.swift
//  LoginPage
//
//  Created by Monica Khoe on 21/08/19.
//  Copyright © 2019 Monica Khoe. All rights reserved.
//

import UIKit

class ViewControllerSignUp: UIViewController {


    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    
    var userDef = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _ = userDef.string(forKey: "email")
        
        _ = userDef.string(forKey: "name")
        
        _ = userDef.string(forKey: "password")
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        userDef.set(emailTF.text, forKey: "email")
        label1.text = emailTF.text
        label2.text = passwordTF.text
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
