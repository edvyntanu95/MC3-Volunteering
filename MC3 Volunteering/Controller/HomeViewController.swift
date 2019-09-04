//
//  ViewController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class HomeViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var notificationEventPageButton: UIBarButtonItem!
    
    @IBOutlet weak var nearbyEventCollectionView: UICollectionView!
    
    @IBOutlet weak var suitableEventTableView: UITableView!
    
    var eventList : [CKRecord] = []
    var event : CKRecord?
    var userDF = UserDefaults.standard
    
    let messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 20
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    func setUpNavBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search events"
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        navigationItem.titleView = searchBar
        searchBar.isTranslucent = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.present(UINavigationController(rootViewController: SearchViewController()), animated: false, completion: nil)
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
//        userDF.set(true, forKey: "isLogin")
//        userDF.set("5D7AD8CE-CEBC-4559-958E-4C18013A10E1", forKey: "sessionID")

//        getDataEventList { (finished) in
//            DispatchQueue.main.async {
//                self.nearbyEventCollectionView.reloadData()
//                self.suitableEventTableView.reloadData()
//            }
//        }
//        nearbyEventCollectionView.isPagingEnabled = true
//        setupNavBar()

    }
    
    var safe : Bool = false
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator("Please wait...")
        safe = false
        eventList = []
        DispatchQueue.global().async {
            self.getDataEventList { (finished) in
                DispatchQueue.main.async {
                    self.effectView.removeFromSuperview()
                    self.safe = true
                    self.nearbyEventCollectionView.reloadData()
                    self.suitableEventTableView.reloadData()
                }
            }
        }
        nearbyEventCollectionView.isPagingEnabled = true
        setUpNavBar()
    }
    
    func getDataEventList(completionHandler: @escaping(_ finished: Bool) -> Void){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RemoteRecords.events, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.resultsLimit = 5
        
        queryOperation.recordFetchedBlock = { record in
            self.eventList.append(record)
            print(record)
        }
        
        queryOperation.queryCompletionBlock = { cursor, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                completionHandler(true)
            }
        }
        DBConnection.share.publicDB.add(queryOperation)
    }
    
    
//    func setupNavBar(){
//
//        let searchNavBarHome = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchNavBarHome
//        navigationItem.hidesSearchBarWhenScrolling = false
//
//    }
    
    @IBAction func unwindSeguesToEventPage(_ sender: UIStoryboardSegue) {
        //--------
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailSegue" {
            let vc = segue.destination as? EventDetailController
            let eventRecordID = event!.recordID.recordName as! String
            vc?.eventId = eventRecordID
            vc?.eventTitle = event![RemoteEvents.name] as! String
            vc?.eventDescription = event![RemoteEvents.description] as! String
            vc?.eventLocation = event![RemoteEvents.location] as! String
            vc?.eventTime = event![RemoteEvents.time] as! String
            vc?.eventDate = event![RemoteEvents.date] as! String
            vc?.eventOrganizer = "Social Designee"
            vc?.numberOFfriends = "3 more friends joins"
            if let asset = event![RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
            {
                vc?.imageEvent = UIImage(data: data)
            }
            vc?.imageFriendPhoto1 = #imageLiteral(resourceName: "human")
            vc?.imageFriendPhoto2 = #imageLiteral(resourceName: "human")
            vc?.imageFriendPhoto3 = #imageLiteral(resourceName: "human")
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = suitableEventTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeCustomTableViewCell
        if safe == true {
            cell.setTableCell(model: eventList[indexPath.row])
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = nearbyEventCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCustomCollectionView
        
        if safe == true {
            cell.setCell(model: eventList[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if safe == true {
        
        event = eventList[indexPath.row]
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailController") as? EventDetailController
//        let eventRecordID = event.recordID.recordName as! String
//        vc?.eventId = eventRecordID
//        vc?.eventTitle = event[RemoteEvents.name] as! String
//        vc?.eventDescription = event[RemoteEvents.description] as! String
//        vc?.eventLocation = event[RemoteEvents.location] as! String
//        vc?.eventTime = event[RemoteEvents.time] as! String
//        vc?.eventDate = event[RemoteEvents.date] as! String
//        vc?.eventOrganizer = "Social Designee"
//        vc?.numberOFfriends = "3 more friends joins"
//        if let asset = event[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
//        {
//            vc?.imageEvent = UIImage(data: data)
//        }
//        vc?.imageFriendPhoto1 = #imageLiteral(resourceName: "human")
//        vc?.imageFriendPhoto2 = #imageLiteral(resourceName: "human")
//        vc?.imageFriendPhoto3 = #imageLiteral(resourceName: "human")
//        self.navigationController?.pushViewController(vc!, animated: true)
            performSegue(withIdentifier: "eventDetailSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if safe == true {
        event = eventList[indexPath.row]
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailController") as? EventDetailController
//        let eventRecordID = event.recordID.recordName as! String
//        vc?.eventId = eventRecordID
//        vc?.eventTitle = event[RemoteEvents.name] as! String
//        vc?.eventDescription = event[RemoteEvents.description] as! String
//        vc?.eventLocation = event[RemoteEvents.location] as! String
//        vc?.eventTime = event[RemoteEvents.time] as! String
//        vc?.eventDate = event[RemoteEvents.date] as! String
//        vc?.eventOrganizer = "Social Designee"
//        vc?.numberOFfriends = "3 more friends joins"
//        if let asset = event[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
//        {
//            vc?.imageEvent = UIImage(data: data)
//        }
//        vc?.imageFriendPhoto1 = #imageLiteral(resourceName: "human")
//        vc?.imageFriendPhoto2 = #imageLiteral(resourceName: "human")
//        vc?.imageFriendPhoto3 = #imageLiteral(resourceName: "human")
//        self.navigationController?.pushViewController(vc!, animated: true)
            
        performSegue(withIdentifier: "eventDetailSegue", sender: nil)
        }
    }
}
