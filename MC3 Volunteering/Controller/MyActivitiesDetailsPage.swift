//
//  MyActivitiesDetailsPage.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class MyActivitiesDetailsPage: UIViewController {
    
    @IBOutlet weak var progressCircle1: UIView!
    @IBOutlet weak var progressCircle2: UIView!
    @IBOutlet weak var progressCircle3: UIView!
    
    
    @IBOutlet weak var lblEventTitle: UILabel!
    
    @IBOutlet weak var lblNumberOfFriends: UILabel!
    
    @IBOutlet weak var lblEventDescription: UILabel!
    
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var lblEventTime: UILabel!
    
    @IBOutlet weak var lblEventDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
    }
    
    func setUpPage(){
        progressCircle1.layer.cornerRadius = progressCircle1.frame.height / 2
        progressCircle2.layer.cornerRadius = progressCircle2.frame.height / 2
        progressCircle3.layer.cornerRadius = progressCircle3.frame.height / 2
        
        lblNumberOfFriends.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1)
    }
    
    func setUpText(){
        
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
