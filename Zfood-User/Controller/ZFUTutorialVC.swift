//
//  ZFUTutorialVC.swift
//  Zfood-User
//
//  Created by apple on 06/06/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit

class ZFUTutorialVC: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swiftyOnboard = SwiftyOnboard(frame: view.frame , style: .dark)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
        UserDefaults.standard.set("GetStarted", forKey: "TUTORIAL")
        print("GetStarted")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setLandingRootViewController()
    }
}

extension ZFUTutorialVC: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        //Number of pages in the onboarding:
        return 3
    }
    
    func swiftyOnboardBackgroundColorFor(_ swiftyOnboard: SwiftyOnboard, atIndex index: Int) -> UIColor? {
        //Return the background color for the page at index:
        return Tutorial.colors[index]
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = SwiftyOnboardPage()
        
        //Set the image on the page:
        view.imageView.image = UIImage(named: "onboard\(index)")
        
        //Set the font and color for the labels:
        view.title.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        view.subTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 18)
        
        //Set the text in the page:
        view.title.text = Tutorial.titleArray[index]
        view.subTitle.text = Tutorial.subTitleArray[index]
        
        //Return the page for the given index:
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        //Setup for the overlay buttons:
        overlay.continueButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.isHidden = true
        } else {
            overlay.continueButton.isHidden = false
            overlay.continueButton.setTitle("Get Started", for: .normal)
        }
    }
    
    
}
