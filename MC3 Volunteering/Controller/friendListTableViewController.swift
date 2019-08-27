//
//  friendListTableViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class friendListTableViewController: UITableViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var ivFriendPhoto: UIImageView!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblNumberOfHours: UILabel!
    @IBOutlet weak var lblNumberOfActivities: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendArray1 = makeFriendArrayObject1()
        friendArray2 = makeFriendArrayObject2()
        friendArray3 = makeFriendArrayObject3()
        friends = [friendArray1,friendArray2,friendArray3]
        
        ivFriendPhoto.layer.cornerRadius = 10
        ivFriendPhoto.layer.masksToBounds = true
        
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        animateOut()
    }
    
    var friendArray1 : [FriendModel] = []
    var friendArray2 : [FriendModel] = []
    var friendArray3 : [FriendModel] = []
    
    func makeFriendArrayObject1() -> [FriendModel] {
        var tempArray : [FriendModel] = []
        
        let model1  = FriendModel.init(friendID: "001", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Haly", lastActive: "5 minutes ago")
        
        let model2 = FriendModel.init(friendID: "002", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Hily", lastActive: "10 minutes ago")
        
        let model3 = FriendModel.init(friendID: "003", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Holy", lastActive: "15 minutes ago")
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        
        return tempArray
    }
    
    func makeFriendArrayObject2() -> [FriendModel] {
        var tempArray : [FriendModel] = []
        
        let model1  = FriendModel.init(friendID: "005", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Edvyn Tanu", lastActive: "5 minutes ago")
        
        let model2 = FriendModel.init(friendID: "006", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Edwyn", lastActive: "10 minutes ago")
        
        let model3 = FriendModel.init(friendID: "007", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Edxyn", lastActive: "15 minutes ago")
        
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        
        return tempArray
    }
    
    func makeFriendArrayObject3() -> [FriendModel] {
        var tempArray : [FriendModel] = []
        
        let model1  = FriendModel.init(friendID: "009", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Monica Khoe", lastActive: "5 minutes ago")
        
        let model2 = FriendModel.init(friendID: "010", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Mooic", lastActive: "10 minutes ago")
        
        let model3 = FriendModel.init(friendID: "011", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Mopic", lastActive: "15 minutes ago")
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
       
        return tempArray
    }
    
    var friends : [[FriendModel]] = []
    
//    var friends = [
//        [["Haly", "15 minutes"], ["Hily", "10 minutes"], ["Holy","20 minutes"]],
//        [["Edvyn", "10 minutes"], ["Edwyn", "3 minutes"], ["Edxyn","3 seconds"]],
//        [["Monic", "2 minutes"], ["Mooic", "4 minnutes"], ["Mopic","2 minutes"]]
//    ]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return friends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendListTableViewCell") as! friendListTableViewCell
        
//        cell.lblFriendName.text = friends[indexPath.section][indexPath.row][0]
//        cell.lblLastActive.text = friends[indexPath.section][indexPath.row][1]
        
        cell.setFriendList(model: friends[indexPath.section][indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(friends[section][0].friendName!.prefix(1))"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn()
        ivFriendPhoto.image = friends[indexPath.section][indexPath.row].friendPhoto
        lblFullName.text = friends[indexPath.section][indexPath.row].friendName
        lblLocation.text = "Tangerang"
        lblNumberOfHours.text = "80"
        lblNumberOfActivities.text = "5"
        var separatedName = friends[indexPath.section][indexPath.row].friendName!.components(separatedBy: " ")
        lblNickname.text = separatedName[0]
    }
    
    func animateIn(){
        self.view.addSubview(visualEffectView)
        visualEffectView.center = self.view.center
        
        self.view.addSubview(popUpView)
        popUpView.center.x = self.view.center.x
        popUpView.center.y = self.view.center.y - 70
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
            self.visualEffectView.removeFromSuperview()
        }
    }

   
}
