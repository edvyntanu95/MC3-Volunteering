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
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblNickName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setUpPage(){
        ivPersonImage.layer.cornerRadius = ivPersonImage.frame.height / 2
        ivPersonImage.layer.masksToBounds = true
        
        addFriendButton.layer.cornerRadius = 20
        addFriendButton.layer.borderColor = #colorLiteral(red: 0.08758807927, green: 0.5526862144, blue: 0.8551954627, alpha: 1)
        addFriendButton.layer.borderWidth = 0.5
        
        viewBackground.backgroundColor = #colorLiteral(red: 0.08758807927, green: 0.5526862144, blue: 0.8551954627, alpha: 1)
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.masksToBounds = true
    }

}
