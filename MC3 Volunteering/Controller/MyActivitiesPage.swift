//
//  MyActivitiesPage.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class MyActivitiesPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        registerEventArray = makeRegisterEventArrayObject()
    }
    
    var registerEventArray: [RegisterEventModel] = []
    
    func makeRegisterEventArrayObject() -> [RegisterEventModel]{
        var tempArray : [RegisterEventModel] = []
        
        let model1 = RegisterEventModel.init(registerEventID: "001", userID: "0001", eventID: "0001", eventPhoto: #imageLiteral(resourceName: "village2"), eventName: "Sightseeing", eventDescription: "Sightseeing with orphanage children", eventLocation: "Austria", eventDate: "Near Future", eventTime: "All Day", eventOrganizer: "Social Designee", status: "Registered", friendPhoto1: #imageLiteral(resourceName: "human"), friendPhoto2: #imageLiteral(resourceName: "human"), friendPhoto3: #imageLiteral(resourceName: "human"))
        
        let model2 = RegisterEventModel.init(registerEventID: "002", userID: "0002", eventID: "0002", eventPhoto: #imageLiteral(resourceName: "Motor"), eventName: "Touring", eventDescription: "Touring with orphanage children", eventLocation: "Austria", eventDate: "Near Future", eventTime: "All Week", eventOrganizer: "Me & You", status: "On Progress", friendPhoto1: #imageLiteral(resourceName: "human"), friendPhoto2: #imageLiteral(resourceName: "human"), friendPhoto3: #imageLiteral(resourceName: "human"))
        
        let model3 = RegisterEventModel.init(registerEventID: "003", userID: "0003", eventID: "0003", eventPhoto: #imageLiteral(resourceName: "village"), eventName: "Exploring", eventDescription: "Exploring with orphanage children", eventLocation: "Austria", eventDate: "Near Future", eventTime: "All Month", eventOrganizer: "Us", status: "Completed", friendPhoto1: #imageLiteral(resourceName: "human"), friendPhoto2: #imageLiteral(resourceName: "human"), friendPhoto3: #imageLiteral(resourceName: "human"))
        
        
        
        tempArray.append(model1)
        tempArray.append(model2)
        tempArray.append(model3)
        
        return tempArray
    }
    


}

extension MyActivitiesPage:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return registerEventArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCollectionViewCell", for: indexPath) as! ActivitiesCollectionViewCell
        cell.setCell(model: registerEventArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyActivitiesDetailsPage") as? MyActivitiesDetailsPage
        
        vc?.eventTitle = registerEventArray[indexPath.row].eventName
        
        vc?.eventDescriptions = registerEventArray[indexPath.row].eventDescription
        
        vc?.eventLocation = registerEventArray[indexPath.row].eventLocation
        
        vc?.eventTime = registerEventArray[indexPath.row].eventTime
        
        vc?.eventDate = registerEventArray[indexPath.row].eventDate
        
        vc?.eventOrganizer = registerEventArray[indexPath.row].eventOrganizer
        
        vc?.numberOFfriends = "3 more friends joins"
        
        vc?.eventImage = registerEventArray[indexPath.row].eventPhoto
        
        vc?.friend1 = registerEventArray[indexPath.row].friendPhoto1
        
        vc?.friend2 = registerEventArray[indexPath.row].friendPhoto2
        
        vc?.friend3 = registerEventArray[indexPath.row].friendPhoto3
        print(registerEventArray[indexPath.row].eventName)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}
