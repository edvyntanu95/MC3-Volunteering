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
    
    @IBOutlet weak var imageViewEvent: UIImageView!
    
    @IBOutlet weak var lblEventTitle: UILabel!
    
    @IBOutlet weak var lblNumberOfFriends: UILabel!
    
    @IBOutlet weak var lblEventDescription: UILabel!
    
    @IBOutlet weak var lblEventLocation: UILabel!
    
    @IBOutlet weak var lblEventTime: UILabel!
    
    @IBOutlet weak var lblEventDate: UILabel!
    
    @IBOutlet weak var lblEventOrganizer: UILabel!
    
    @IBOutlet weak var imageViewFriend1: UIImageView!
    
    @IBOutlet weak var imageViewFriend2: UIImageView!
    
    @IBOutlet weak var imageViewFriend3: UIImageView!
    
    @IBOutlet weak var imageViewEventOrganizer: UIImageView!
    
    var eventId:String?
    var eventTitle: String?
    var numberOFfriends: String?
    var eventDescriptions: String?
    var eventLocation: String?
    var eventTime: String?
    var eventDate: String?
    var eventOrganizer: String?
    
    var eventImage: UIImage?
    var friend1: UIImage?
    var friend2: UIImage?
    var friend3: UIImage?
    var eventOrganizerPhoto: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
        setUpText()
    }
    
    func setUpPage(){
        progressCircle1.layer.cornerRadius = progressCircle1.frame.height / 2
        progressCircle1.layer.masksToBounds = true
        
        progressCircle2.layer.cornerRadius = progressCircle2.frame.height / 2
        progressCircle2.layer.masksToBounds = true
        
        progressCircle3.layer.cornerRadius = progressCircle3.frame.height / 2
        progressCircle3.layer.masksToBounds = true
        
        imageViewFriend1.layer.cornerRadius = imageViewFriend1.frame.height / 2
        imageViewFriend1.layer.masksToBounds = true
        
        imageViewFriend2.layer.cornerRadius = imageViewFriend2.frame.height / 2
        imageViewFriend2.layer.masksToBounds = true
        
        imageViewFriend3.layer.cornerRadius = imageViewFriend3.frame.height / 2
        imageViewFriend3.layer.masksToBounds = true
        imageViewEventOrganizer.layer.cornerRadius = imageViewEventOrganizer.frame.height / 2
        imageViewEventOrganizer.layer.masksToBounds = true
        
        lblNumberOfFriends.textColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1)
    }
    
    func setUpText(){
        lblEventTitle.text = eventTitle
        lblNumberOfFriends.text = numberOFfriends
        lblEventDescription.text = eventDescriptions
        lblEventLocation.text = eventLocation
        lblEventTime.text = eventTime
        lblEventDate.text = eventDate
        lblEventOrganizer.text = eventOrganizer
        
        imageViewEvent.image = eventImage
        imageViewFriend1.image = friend1
        imageViewFriend2.image = friend2
        imageViewFriend3.image = friend3
        imageViewEventOrganizer.image = eventOrganizerPhoto
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
