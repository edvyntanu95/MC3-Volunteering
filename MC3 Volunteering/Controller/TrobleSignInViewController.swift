//
//  TrobleSignInViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 03/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class TrobleSignInViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continueButton.layer.cornerRadius = 20
        continueButton.layer.masksToBounds = true
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   

}
