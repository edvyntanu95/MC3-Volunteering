//
//  QRCodeViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ivQRCode: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var userName: String?
    var generateQRcodeString: String = "wolololo"
    
    var backBarButtonItem = UIBarButtonItem.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblUsername.text = userName
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        generateQRcode()
        
    }
    
    func generateQRcode(){
        let data = generateQRcodeString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "InputMessage")
            
        let ciImage = filter?.outputImage
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformImage = ciImage?.transformed(by: transform)
            
        let image = UIImage(ciImage: transformImage!)
        ivQRCode.image = image
        
        
    }

}
