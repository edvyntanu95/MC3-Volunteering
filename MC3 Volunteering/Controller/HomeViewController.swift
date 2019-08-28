//
//  ViewController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var notificationEventPageButton: UIBarButtonItem!
    
    @IBOutlet weak var nearbyEventCollectionView: UICollectionView!
    
    @IBOutlet weak var suitableEventTableView: UITableView!
    
    var eventArray : [EventModel] = []
    
    func makeEventArrayObject() -> [EventModel]{
        var tempArray : [EventModel] = []
        
        let model1 = EventModel.init(eventID: "001", eventName: "Seeing the world", eventDescription: "Seeing the world with orphan kids", eventLocation: "Austria, Switzerland", eventDate: "Next 3 months", eventPhoto: #imageLiteral(resourceName: "village"), eventTime: "3 months", eventFee: 0000, eventOrganizer: "You & I", userIDs: ["001","002"])
        
        let model2 = EventModel.init(eventID: "002", eventName: "Seeing the space", eventDescription: "Seeing the space with orphan kids", eventLocation: "Andromeda Galaxy, Orion's Belt", eventDate: "Next 30 year", eventPhoto: #imageLiteral(resourceName: "village2"), eventTime: "30 year", eventFee: 0000, eventOrganizer: "The Universe", userIDs: ["003","004"])
        
        let model3 = EventModel.init(eventID: "003", eventName: "Seeing the galaxy", eventDescription: "Seeing the stars with orphan kids", eventLocation: "Andromeda Galaxy, Orion's Belt and more", eventDate: "Next 300 year", eventPhoto: #imageLiteral(resourceName: "village2"), eventTime: "300 year", eventFee: 0000, eventOrganizer: "The Universe", userIDs: ["005","006"])
        

        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        
        return tempArray
    }
    
    
    let imageSliderArray = [UIImage(named: "Berenang"), UIImage(named: "Anjing"), UIImage(named: "Lampu Merah"), UIImage(named: "Surfing"), UIImage(named: "Motor")]
    
    var imageSelected: Int?
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.providesPresentationContextTransitionStyle = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    nearbyEventCollectionView.isPagingEnabled = true
        
        eventArray = makeEventArrayObject()
        
        setupNavBar()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
    }

    
    func setupNavBar(){

        let searchNavBarHome = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchNavBarHome
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    

    
    @IBAction func unwindSeguesToEventPage(_ sender: UIStoryboardSegue) {}
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = suitableEventTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeCustomTableViewCell
        
        cell.setTableCell(model: eventArray[indexPath.row])
        
        return cell
    }
    
    
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return eventArray.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = nearbyEventCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCustomCollectionView
    cell.setCell(model: eventArray[indexPath.row])
    
//    if(collectionView == eventHomeCollectionView){
//        let cell2 = eventHomeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! CustomScroll
//        cell2.scrollImage.image = imageSliderArray[indexPath.row]
////        cell2.scrollHeaderText.text = "EDVYN YEAYY !!! "
//
//        return cell2
//
//    }
    
    
    return cell
}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailController") as? EventDetailController
        
        vc?.eventTitle = eventArray[indexPath.row].eventName
        vc?.eventDescription = eventArray[indexPath.row].eventDescription
        vc?.eventLocation = eventArray[indexPath.row].eventLocation
        vc?.eventTime = eventArray[indexPath.row].eventTime
        vc?.eventDate = eventArray[indexPath.row].eventDate
        vc?.eventOrganizer = eventArray[indexPath.row].eventOrganizer
        vc?.numberOFfriends = "3 more friends joins"
        vc?.imageEvent = eventArray[indexPath.row].eventPhoto
        vc?.imageFriendPhoto1 = #imageLiteral(resourceName: "human")
        vc?.imageFriendPhoto2 = #imageLiteral(resourceName: "human")
        vc?.imageFriendPhoto3 = #imageLiteral(resourceName: "human")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailController") as? EventDetailController
        
        vc?.eventTitle = eventArray[indexPath.row].eventName
        vc?.eventDescription = eventArray[indexPath.row].eventDescription
        vc?.eventLocation = eventArray[indexPath.row].eventLocation
        vc?.eventTime = eventArray[indexPath.row].eventTime
        vc?.eventDate = eventArray[indexPath.row].eventDate
        vc?.eventOrganizer = eventArray[indexPath.row].eventOrganizer
        vc?.numberOFfriends = "3 more friends joins"
        vc?.imageEvent = eventArray[indexPath.row].eventPhoto
        vc?.imageFriendPhoto1 = #imageLiteral(resourceName: "human")
        vc?.imageFriendPhoto2 = #imageLiteral(resourceName: "human")
        vc?.imageFriendPhoto3 = #imageLiteral(resourceName: "human")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}
