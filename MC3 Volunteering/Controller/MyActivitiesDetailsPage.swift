//
//  MyActivitiesDetailsPage.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import MessageUI

class MyActivitiesDetailsPage: UIViewController {
    
    
    // outlet for progress
    @IBOutlet weak var progressCircle1: UIView!
    @IBOutlet weak var progressCircle2: UIView!
    @IBOutlet weak var progressCircle3: UIView!
    
    @IBOutlet weak var circleFillRegister: UIView!
    @IBOutlet weak var circleFillEvent: UIView!
    @IBOutlet weak var circleFillCertificate: UIView!
    
    
    // outlet for the rest
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
    
    var eventStatus: String?
    
    var eventImage: UIImage?
    var friend1: UIImage?
    var friend2: UIImage?
    var friend3: UIImage?
    var eventOrganizerPhoto: UIImage?
    
    func makeASMS(){
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Hai Kak Saya Ingin Mengikuti Event Ini, Apakah Masih Tersedia Slotnya ?"
            controller.recipients = ["087889901930"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func makeAPhoneCall()  {
        let url: NSURL = URL(string: "TEL://087889901930")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func tapToCall(_ sender: UIButton) {
        makeAPhoneCall()
    }
    
    @IBAction func tapToSMS(_ sender: Any) {
        makeASMS()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
        setUpText()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        circleFillRegister.alpha = 0
        circleFillEvent.alpha = 0
        circleFillCertificate.alpha = 0
        if eventStatus == "Registered" {
            UIView.animate(withDuration: 0.3) {
                self.circleFillRegister.alpha = 1
            }
            if eventStatus == "Event" {
                UIView.animate(withDuration: 0.3) {
                    self.circleFillEvent.alpha = 1
                }
                if eventStatus == "Certificate" {
                    UIView.animate(withDuration: 0.3) {
                        self.circleFillCertificate.alpha = 1
                    }
                }
            }
        }
    }
    
    func progressUpdate(){
        
    }
    
    func setUpPage(){
        progressCircle1.layer.cornerRadius = progressCircle1.frame.height / 2
        progressCircle1.layer.masksToBounds = true
        
        progressCircle2.layer.cornerRadius = progressCircle2.frame.height / 2
        progressCircle2.layer.masksToBounds = true
        
        progressCircle3.layer.cornerRadius = progressCircle3.frame.height / 2
        progressCircle3.layer.masksToBounds = true
        
        circleFillRegister.layer.cornerRadius = circleFillRegister.frame.height/2
        circleFillRegister.layer.masksToBounds = true
        
        circleFillEvent.layer.cornerRadius = circleFillEvent.frame.height/2
        circleFillEvent.layer.masksToBounds = true
        
        circleFillCertificate.layer.cornerRadius = circleFillCertificate.frame.height/2
        circleFillCertificate.layer.masksToBounds = true
        
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

extension MyActivitiesDetailsPage: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


