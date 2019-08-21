//
//  DetailedEvent.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class DetailedEvent: UIViewController {

    @IBOutlet weak var imageDetailedEvent: UIImageView!
    
    var imageContainer: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDetailedEvent.image = imageContainer
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageTapped(recognizer:UITapGestureRecognizer){
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
