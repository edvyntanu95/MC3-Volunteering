//
//  FriendListController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class FriendListController: UIViewController{
    
    var friendArray : [FriendModel] = []
    
    func makeFriendArrayObject() -> [FriendModel] {
        var tempArray : [FriendModel] = []
        
        let model1  = FriendModel.init(friendID: "001", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Hadi", lastActive: "5 minutes ago")
        
        let model2 = FriendModel.init(friendID: "002", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Edvyn", lastActive: "10 minutes ago")
        
        let model3 = FriendModel.init(friendID: "003", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Ben", lastActive: "15 minutes ago")
        
        let model4 = FriendModel.init(friendID: "004", friendPhoto: #imageLiteral(resourceName: "human"), friendName: "Monic", lastActive: "20 minutes ago")
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        tempArray.append(model4)
        
        return tempArray
    }
    
    @IBAction func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableViewCell: ClickableTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendArray = makeFriendArrayObject()
    }
    
    @IBAction func inviteButtonFriendList(_ sender: Any) {
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performSegue(withIdentifier: "selectPreferenceRole", sender: nil)
    }
    
}

extension FriendListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! ClickableTableViewCell
        
        cell.setInviteYourFriends(model: friendArray[indexPath.row])
        
        return cell
    }
    
    func checkableTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as? ClickableTableViewCell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
