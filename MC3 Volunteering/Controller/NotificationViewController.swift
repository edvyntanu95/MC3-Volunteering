//
//  NotificationViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 28/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class NotificationViewController: UIViewController {
    
    // ========= outlets for pop up view
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var ivEventPhoto: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDateAndTime: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    @IBOutlet weak var buttonSeeDetail: UIButton!
    @IBOutlet weak var buttonDecline: UIButton!
    @IBOutlet weak var buttonAccept: UIButton!
    
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    // ========== var for logics
    
    var notifList : [CKRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visualEffectView.isHidden = true
        setUpButtons()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NotificationViewController.userDidTapped))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(NotificationViewController.userDidTapped))
        
        popUpView.addGestureRecognizer(tap)
        visualEffectView.addGestureRecognizer(tap2)
        
    }
    
    
    @objc func userDidTapped(tap: UITapGestureRecognizer){
        if popUpView.alpha == 1 {
            animateOut()
        }
    }
    
    
    func setUpButtons(){
        buttonDecline.layer.borderWidth = 0.5
        buttonDecline.layer.borderColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        buttonDecline.tintColor = #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1)
        
        buttonDecline.layer.cornerRadius = 10
        buttonDecline.layer.masksToBounds = true
        
        buttonAccept.layer.cornerRadius = 10
        buttonAccept.layer.masksToBounds = true
    }
    
    func animateIn(){
        self.view.addSubview(popUpView)
        
        popUpView.center = self.view.center
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        
        
        tabBarController?.tabBar.alpha = 0.5
        tabBarController?.tabBar.isUserInteractionEnabled = false
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
        
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.isHidden = false
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut(){
        
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        self.navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem?.accessibilityElementsHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            self.popUpView.alpha = 0
            self.visualEffectView.isHidden = true
            self.tabBarController?.tabBar.alpha = 1.0
        }) { (success: Bool) in
            self.popUpView.removeFromSuperview()
            
        }
    }

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Notification Cell") as! NotificationTableViewCell
        cell.ivUserImage.image = #imageLiteral(resourceName: "human")
        cell.lblName.text = "Pramahadi"
        cell.lblLastActive.text = "10 minutes ago"
        //cell.setCell(model: notifList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn()
        
        ivEventPhoto.image = #imageLiteral(resourceName: "village2")
        lblEventName.text = "Cleaning"
        lblEventDateAndTime.text = "Papap"
        lblEventLocation.text = "lokasi lokasi"
    }
    
    
    
}
