//
//  FriendListController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class FriendListController: UIViewController{
    
    var fotoTemen = ["Temen1","Temen2"]
    var namaTemen = ["Edvyn","Hadi"]
    var lastOnline =
        [",",","]
    
    
    @IBOutlet weak var tableViewCell: ClickableTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return fotoTemen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! ClickableTableViewCell
        
        cell.gambar.image = UIImage(named: fotoTemen[indexPath.row])
        cell.lblName.text = namaTemen[indexPath.row]
        
        return cell
    }
    
    func checkableTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ClickableTableViewCell)!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
