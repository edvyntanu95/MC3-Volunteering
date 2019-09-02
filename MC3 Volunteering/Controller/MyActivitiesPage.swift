//
//  MyActivitiesPage.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 25/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import CloudKit

class MyActivitiesPage: UIViewController {
    
    var myActivitiesEventList:[CKRecord] = []
    var myActivitiesEventsListStatus:[CKRecord] = []
    @IBOutlet weak var myActivitiesCV: UICollectionView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getMyActivitiesEventList { (finished) in
//            DispatchQueue.main.async {
//                self.myActivitiesCV.reloadData()
//            }
//        }
//    }
    
    var safe: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        safe = false
        myActivitiesEventList = []
        myActivitiesEventsListStatus = []
        
        getMyActivitiesEventList { (finished) in
            DispatchQueue.main.async {
                self.safe = true
                self.myActivitiesCV.reloadData()
            }
        }
    }
    
    
    func getMyActivitiesEventList(completionHandler: @escaping (_ finished: Bool) -> Void){
    
        let userDF = UserDefaults.standard
        var recordUserID = CKRecord.ID(recordName: userDF.string(forKey: "sessionID")!)
        let userReference = CKRecord.Reference(recordID: recordUserID, action: .none)
        let predicate = NSPredicate(format: "recordUserID == %@", userReference)
        let query = CKQuery(recordType: RemoteRecords.registerEvents, predicate: predicate)
    
    
        DBConnection.share.publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                guard let records = records else {return}
                var recordNames:[CKRecord.ID] = []
                for record in records {
                    let eventReference = record[RemoteRegisterEvents.eventId] as! CKRecord.Reference
                    self.myActivitiesEventsListStatus.append(record)
                    recordNames.append(eventReference.recordID)
                }
    
                print(recordNames.count)
    
                let operation = CKFetchRecordsOperation(recordIDs: recordNames)
                operation.fetchRecordsCompletionBlock = { (records, error) in
                    guard let records = records else {return}
                    for (key, value) in records {
                        self.myActivitiesEventList.append(value)
                    }
                    completionHandler(true)
                }
                DBConnection.share.publicDB.add(operation)
            }
        }
    }
            
}

extension MyActivitiesPage:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myActivitiesEventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCollectionViewCell", for: indexPath) as! ActivitiesCollectionViewCell
        if safe == true {
            let myActivity = myActivitiesEventList[indexPath.row]
            let myActivityStatus = myActivitiesEventsListStatus[indexPath.row]
            cell.setCell(myActivity: myActivity, myActivityStatus: myActivityStatus)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if safe == true{
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyActivitiesDetailsPage") as? MyActivitiesDetailsPage
        let myActivity = myActivitiesEventList[indexPath.row]
        let myActivityStatus = myActivitiesEventsListStatus[indexPath.row]
        
        let eventRecordID = myActivity.recordID.recordName as! String
        vc?.eventId = eventRecordID
        
        vc?.eventTitle = myActivity[RemoteEvents.name] as! String
        
        vc?.eventDescriptions = myActivity[RemoteEvents.description] as! String
        
        vc?.eventLocation = myActivity[RemoteEvents.location] as! String
        
        vc?.eventTime = myActivity[RemoteEvents.time] as! String
        
        vc?.eventDate = myActivity[RemoteEvents.date] as! String
        
        vc?.eventOrganizer = myActivity[RemoteEvents.organizer] as! String
        
        vc?.numberOFfriends = "3 more friends joins"
        
        if let asset = myActivity[RemoteEvents.photo] as? CKAsset, let data = try? Data(contentsOf: asset.fileURL!)
        {
            vc?.eventImage = UIImage(data: data)
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
}
