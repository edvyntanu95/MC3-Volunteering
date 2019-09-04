//
//  SearchFriendsViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 04/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class SearchFriendsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCurrentArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    var currentArray : [friends] = []
    var friendsArray : [friends] = []
    
    func makeCurrentArray(){
        currentArray.append(friends.init(name: "Joni", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Star", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Marco", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Edvyn", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Monic", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Daniel", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Benjamin", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Hadi", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "Trevin", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "AAAA", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "AAAB", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "AABB", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "ABBB", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "BAAA", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "BBAA", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "BBBA", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "BBBB", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "ABAB", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "BABA", picture: #imageLiteral(resourceName: "human")))
        currentArray.append(friends.init(name: "ABBA", picture: #imageLiteral(resourceName: "human")))
        
        friendsArray = currentArray
    }
    
}

extension SearchFriendsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currentArray = friendsArray
            searchTableView.reloadData()
            return
        }
        currentArray = friendsArray.filter({ (friends) -> Bool in
           friends.name!.lowercased().contains(searchText.lowercased())
        })
        searchTableView.reloadData()
    }
    
}

extension SearchFriendsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBarTableViewCell") as! SearchBarTableViewCell
        cell.ivUserPicture.image = currentArray[indexPath.row].picture
        cell.lblUserName.text = currentArray[indexPath.row].name
        return cell
    }
}

class friends{
    var name: String?
    var picture: UIImage?
    
    init(name: String, picture: UIImage) {
        self.name = name
        self.picture = picture
    }
}
