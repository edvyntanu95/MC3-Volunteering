//
//  OnBoardingViewController.swift
//  MC3 Volunteering
//
//  Created by Trevin John Rutherford on 02/09/19.
//  Copyright © 2019 Silamitra Edvyn Tanu. All rights reserved.
//

import UIKit
import paper_onboarding

class OnBoardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBoardingView.delegate = self
        onBoardingView.dataSource = self
        self.volunteerButton.alpha = 0
        self.communityButton.alpha = 0
        self.ivAppLogo.alpha = 0
        setUpView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var pages : [OnboardingItemInfo] = []
    
    func makePages() -> [OnboardingItemInfo]{
        pages.removeAll()
        var tempArray : [OnboardingItemInfo] = []
        
        
        let page1 = OnboardingItemInfo.init(informationImage: #imageLiteral(resourceName: "loveHands"), title: "", description: "Be kind while there is still time", pageIcon: #imageLiteral(resourceName: "loveHands"), color: #colorLiteral(red: 0.002539749956, green: 0.3627195954, blue: 0.6189824939, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont.init(name: "Helvetica", size: 24)!, descriptionFont: UIFont.init(name: "Helvetica", size: 17)!)
        
        let page2 = OnboardingItemInfo.init(informationImage: #imageLiteral(resourceName: "groupLove"), title: "", description: "More fun when you do it with your friends", pageIcon: #imageLiteral(resourceName: "groupLove"), color: #colorLiteral(red: 0.002539749956, green: 0.3627195954, blue: 0.6189824939, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont.init(name: "Helvetica", size: 24)!, descriptionFont: UIFont.init(name: "Helvetica", size: 17)!)
        
        let page3 = OnboardingItemInfo.init(informationImage: #imageLiteral(resourceName: "heroes"), title: "", description: "Let's volunteer", pageIcon: #imageLiteral(resourceName: "heroes"), color: #colorLiteral(red: 0.002539749956, green: 0.3627195954, blue: 0.6189824939, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont.init(name: "Helvetica", size: 24)!, descriptionFont: UIFont.init(name: "Helvetica", size: 17)!)
        
        let page4 = OnboardingItemInfo.init(informationImage: #imageLiteral(resourceName: "Rectangle"), title: "", description: "", pageIcon: #imageLiteral(resourceName: "Alternatif Logo VoluntR-2"), color: #colorLiteral(red: 0, green: 0.362134397, blue: 0.6190385222, alpha: 1), titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont.init(name: "Helvetica", size: 24)!, descriptionFont: UIFont.init(name: "Helvetica", size: 17)!)
        
        
        tempArray.append(page1)
        tempArray.append(page2)
        tempArray.append(page3)
        tempArray.append(page4)
        
        return tempArray
    }
    
    func onboardingItemsCount() -> Int {
        pages = makePages()
        return pages.count
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        pages = makePages()
        return pages[index]
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 2 {
            if self.volunteerButton.alpha == 1 {
                UIView.animate(withDuration: 0.2) {
                    self.volunteerButton.alpha = 0
                    self.communityButton.alpha = 0
                    self.ivAppLogo.alpha = 0
                }
            }
        } else if index == 3 {
            UIView.animate(withDuration: 0.2) {
                self.volunteerButton.alpha = 1
                self.communityButton.alpha = 1
                self.ivAppLogo.alpha = 1
            }
        }
    }
    
//    func onboardingDidTransitonToIndex(_ index: Int) {
//        if index == 3 {
//            UIView.animate(withDuration: 0.2) {
//                self.volunteerButton.alpha = 1
//                self.communityButton.alpha = 1
//                self.ivAppLogo.alpha = 1
//            }
//        }
//    }
    
    
    
    @IBOutlet weak var onBoardingView: OnBoardingView!
    
    @IBOutlet weak var volunteerButton: UIButton!
    @IBOutlet weak var communityButton: UIButton!
    @IBOutlet weak var ivAppLogo: UIImageView!
    
    func setUpView(){
        volunteerButton.layer.cornerRadius = 10
        volunteerButton.tintColor = #colorLiteral(red: 0, green: 0.6295064092, blue: 0.9766119123, alpha: 1)
        volunteerButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        volunteerButton.layer.masksToBounds = true
        
        communityButton.layer.cornerRadius = 10
        communityButton.tintColor = #colorLiteral(red: 0, green: 0.6295064092, blue: 0.9766119123, alpha: 1)
        communityButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        communityButton.layer.masksToBounds = true
        
        ivAppLogo.layer.cornerRadius = 10
        ivAppLogo.layer.masksToBounds = true
    }
    
    
    @IBAction func volunteerButtonPressed(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onBoardingComplete")
        userDefaults.synchronize()
    }
    
    @IBAction func communityButtonPressed(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onBoardingComplete")
        userDefaults.synchronize()
    }
    
}
