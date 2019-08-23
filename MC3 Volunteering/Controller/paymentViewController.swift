//
//  paymentViewController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 23/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class paymentViewController: UIViewController {

    @IBOutlet weak var paymentViewLabel: UILabel!
    @IBOutlet weak var paymentDueDateLabel: UILabel!
    @IBOutlet weak var bankAccountNumberLabel: UILabel!
    @IBOutlet weak var bankAccountNameLabel: UILabel!
    @IBOutlet weak var dateReceiptUploadLabel: UILabel!
    
     @IBOutlet weak var uploadPaymentReceiptButton: UIButton!
    @IBOutlet weak var paymentProceedButton: UIButton!
    @IBOutlet weak var paymentLaterButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonDesign()
        
    }
    
    func buttonDesign() {
        paymentLaterButton.layer.borderColor = #colorLiteral(red: 0.3039953709, green: 0.6345664263, blue: 0.8838434815, alpha: 1)
        paymentLaterButton.layer.borderWidth = 1
        paymentProceedButton.layer.borderColor = #colorLiteral(red: 0.3039953709, green: 0.6345664263, blue: 0.8838434815, alpha: 1)
        paymentProceedButton.layer.borderWidth = 1
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
