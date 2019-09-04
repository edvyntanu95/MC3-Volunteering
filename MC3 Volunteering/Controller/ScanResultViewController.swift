//
//  ScanResultViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class ScanResultViewController: UIViewController {
    
    @IBOutlet weak var ivPersonImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var addFriendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUpPage(){
        ivPersonImage.layer.cornerRadius = ivPersonImage.frame.height / 2
    }

}
