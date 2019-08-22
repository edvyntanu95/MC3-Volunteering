//
//  ViewController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 20/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var nearbyEventCollectionView: UICollectionView!
    
    @IBOutlet weak var suitableEventTableView: UITableView!
    
    
    let imageSliderArray = [UIImage(named: "Berenang"), UIImage(named: "Anjing"), UIImage(named: "Lampu Merah"), UIImage(named: "Surfing"), UIImage(named: "Motor")]
    
    var imageSelected: Int?
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.providesPresentationContextTransitionStyle = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyEventCollectionView.isPagingEnabled = true
//
//        setupNavBar()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }

    
//    func setupNavBar(){
//
//        let searchNavBarHome = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchNavBarHome
//        navigationItem.hidesSearchBarWhenScrolling = false
//
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationEventDetailed = segue.destination as! EventDetailController
        destinationEventDetailed.imageContainer = imageSliderArray[imageSelected!]
        
    }
    
    @IBAction func unwindSeguesToEventPage(_ sender: UIStoryboardSegue) {}
    
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageSliderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = suitableEventTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! HomeCustomTableViewCell
        
        cell.tableViewCellHomeImage.image = imageSliderArray[indexPath.row]
        
        return cell
    }
    
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //if(collectionView == scrollView){
    // return imagescrollArray.count
    //}
    return imageSliderArray.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = nearbyEventCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionView
    
    cell.imageSliderHome.image = imageSliderArray[indexPath.row]
    
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
        imageSelected = indexPath.row
        performSegue(withIdentifier: "goToEventDetailed", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imageSelected = indexPath.row
        performSegue(withIdentifier: "goToEventDetailed", sender: nil)
    }
    
    
}
