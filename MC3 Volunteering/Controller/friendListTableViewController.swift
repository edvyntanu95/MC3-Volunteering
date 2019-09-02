//
//  friendListTableViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 27/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class friendListTableViewController: UITableViewController {
    var contacts: [CNContact] = []
    var myFriends: [CKRecord] = []
    @IBOutlet var popUpView: UIView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var ivFriendPhoto: UIImageView!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblNumberOfHours: UILabel!
    @IBOutlet weak var lblNumberOfActivities: UILabel!
    
    @IBOutlet var myFriendList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        friendArray1 = makeFriendArrayObject1()
//        friendArray2 = makeFriendArrayObject2()
//        friendArray3 = makeFriendArrayObject3()
        
        getMyFriendList { (finished) in
            if finished {
                print("Friend List Berhasil Di Load")
                print(self.friends.count)
                
                DispatchQueue.main.async {
                    self.myFriendList.reloadData()
                }
                
            }
        }
        
        getAllContact { (finished) in
            if finished {
                for contact in self.contacts {
                    print(contact.givenName)
                }
            }
        }

        
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
    
    var friends : [CKRecord] = []
    
//    var friends = [
//        [["Haly", "15 minutes"], ["Hily", "10 minutes"], ["Holy","20 minutes"]],
//        [["Edvyn", "10 minutes"], ["Edwyn", "3 minutes"], ["Edxyn","3 seconds"]],
//        [["Monic", "2 minutes"], ["Mooic", "4 minnutes"], ["Mopic","2 minutes"]]
//    ]

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return friends.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendListTableViewCell") as! friendListTableViewCell
        
//        cell.lblFriendName.text = friends[indexPath.section][indexPath.row][0]
//        cell.lblLastActive.text = friends[indexPath.section][indexPath.row][1]
        
        cell.setFriendList(model: friends[indexPath.row])
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(friends[section].prefix(1))"
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateIn()
        
        let friend = friends[indexPath.row]
        
        if let asset = friend[RemoteUsers.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            DispatchQueue.main.async {
                self.ivFriendPhoto.image = UIImage(data: data)
            }
        }
        
        lblFullName.text = friend[RemoteUsers.userBio]
        lblLocation.text = "Tangerang"
        lblNumberOfHours.text = "80"
        lblNumberOfActivities.text = "5"
        lblNickname.text = friend[RemoteUsers.name]
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
    
    func getMyFriendList(completionHandler: @escaping (_ finished: Bool) -> Void){
        
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        let predicate = NSPredicate(format: "userID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.friends, predicate: predicate)
        
        
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                var recordNames:[CKRecord.ID] = []
                for record in records {
                    let friendReference = record[RemoteFriends.friendId] as! CKRecord.Reference
                    recordNames.append(friendReference.recordID)
                }
                
                print(recordNames.count)
                
                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
                operation.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.friends.append(value)
                    }
                    completionHandler(true)
                }
                DBConnection.share.publicDB.add(operation)
            }
        }
    }
    
    func getAllContact(completionHandler: @escaping(_ finished: Bool) -> Void){
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            
            if let error = error {
                print("Failed to fetch request", error)
                return
            }
            
            if granted {
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                do {
                    try store.enumerateContacts(with: request) {
                        (contact, stop) in
                        // Array containing all unified contacts from everywhere
                        self.contacts.append(contact)
                        completionHandler(true)
                    }
                }
                catch {
                    print("unable to fetch contacts")
                }
                
                
                
//                let keys = [CNContactGivenNameKey]
//                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//                do {
//                    try store.enumerateContacts(with: request) { (contact, stopEnumerating) in
//                        self.contacts.append(contact)
//                        completionHandler(true)
//                    }
//                }catch let error {
//                    print("Failed to fetch contact", error)
//                }
            }
            
            
        }
        
        
        
        
        
        
    }

   
}
