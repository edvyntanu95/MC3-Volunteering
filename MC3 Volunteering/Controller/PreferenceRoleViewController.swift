//
//  PreferenceRoleViewController.swift
//  MC3 Volunteering
//
//  Created by Silamitra Edvyn Tanu on 23/08/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit

class PreferenceRoleViewController: UIViewController {

    @IBOutlet weak var prTanggalCollectionView: UICollectionView!
    
    @IBOutlet weak var prCollectionView: UICollectionView!

//    let cellScale: CGFloat = 0.6
    
    let preferenceRoleImageArray = [UIImage(named: "Berenang"), UIImage(named: "Anjing"), UIImage(named: "Lampu Merah"), UIImage(named: "Surfing"), UIImage(named: "Motor")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScale)
//        let cellHeight = floor(screenSize.height * cellScale)
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//
//
//        let layoutRole = prCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//
//        layoutRole.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        prCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        
        
       prCollectionView.isPagingEnabled = true
    }
    
    
}

extension PreferenceRoleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == prTanggalCollectionView {
            return 4
        }
        
        return preferenceRoleImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = prCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PreferenceRoleCollectionViewCell
        
        cell.preferenceRoleImage.image = preferenceRoleImageArray[indexPath.row]
        
        
        
        if(collectionView == prTanggalCollectionView){
        let cell2 = prTanggalCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! TanggalCollectionView
        
            cell2.customFontLabelTanggal()
            
            return cell2
            
            }
        
        
        return cell
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.prCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundIndex = round(index)
//
//        offset = CGPoint(x: roundIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//
//    }

}

