//
//  SettingProfileViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 28/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class SettingProfileViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myLocation: UITextView!
    @IBOutlet weak var myInterest: UITextView!
    
    var name: String?
    var location: String?
    var passion: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextView.text = name
        myLocation.text = location
        myInterest.text = passion
        
        
        
        myTextView.isEditable = true
        myInterest.isEditable = true
        myLocation.isEditable = true
        
        
        myTextView.textColor = UIColor.lightGray
        myTextView.returnKeyType = .done
        myTextView.delegate = self
        
        myLocation.textColor = UIColor.lightGray
        myLocation.returnKeyType = .done
        myLocation.delegate = self
        
        myInterest.textColor = UIColor.lightGray
        myInterest.returnKeyType = .done
        myInterest.delegate = self
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            myTextView.resignFirstResponder()
            myInterest.resignFirstResponder()
            myLocation.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == name{
            textView.text = ""
            textView.textColor = UIColor.black
        }
        if myLocation.text == location{
            textView.text = ""
            textView.textColor = UIColor.black
        }
        if myInterest.text == passion{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    
    


}
