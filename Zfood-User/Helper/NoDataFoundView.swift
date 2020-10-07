//
//  NoDataFoundView.swift
//  Hopper
//
//  Created by Jaypreet on 01/06/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import UIKit
import Lottie

class NoDataFoundView: UIView {
    
    var lbl = UILabel()
    var img = UIImageView()
    var btn = UIButton()
    var animationView = AnimationView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Show()
    }
 
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 250, height: 300))
        Show()
        
    }
    
  
    func Show()  {
        backgroundColor = UIColor.clear
//        let animationView = LOTAnimationView(name: "empty_list")
//        animationView.frame = CGRect(x: 0, y: -50, width: 250, height: 250)
//        animationView.center = center
//        animationView.contentMode = .scaleAspectFill
//
//        addSubview(animationView)
//        animationView.loopAnimation = true
//
//        animationView.play()
//        let screenSize = UIScreen.main.bounds
//        if tag == 22{
//            img = UIImageView.init(frame: CGRect.init(x: frame.size.width/2 - 40, y: 10 , width: 80, height: 80))
//            lbl = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height - 95, width: screenSize.width - 80, height: 50))
//            btn = UIButton.init(frame: CGRect.init(x: (screenSize.width - 60)/2 - 20, y: frame.size.height - 45, width: 40, height: 40))
//        }
//        else if tag == 11{
//            img = UIImageView.init(frame: CGRect.init(x: frame.size.width/2 - 40, y: 10 , width: 80, height: 80))
//            lbl = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height - 95, width: screenSize.width - 80, height: 50))
//            btn = UIButton.init(frame: CGRect.init(x: (screenSize.width - 60)/2 - 20, y: frame.size.height - 45, width: 40, height: 40))
//        }
//        else{
//            img = UIImageView.init(frame: CGRect.init(x: 0, y: 0 , width: screenSize.width - 60, height: frame.size.height - 120))
//            lbl = UILabel.init(frame: CGRect.init(x: 10, y: frame.size.height - 120, width: screenSize.width - 80, height: 70))
//            btn = UIButton.init(frame: CGRect.init(x: (screenSize.width - 60)/2 - 20, y: frame.size.height - 40, width: 40, height: 40))
//        }
//        img.image = #imageLiteral(resourceName: "no_shop_found")
//        img.contentMode = .scaleAspectFit
//        img.clipsToBounds = true
//
//        addSubview(img)

        let screenSize = UIScreen.main.bounds
        animationView = AnimationView(name: "EmptyList")

        lbl = UILabel.init(frame: CGRect.init(x: 0, y: 130, width: 240 , height: 50))
        btn = UIButton.init(frame: CGRect.init(x: 0100, y: 190  , width: 40, height: 40))

       
        lbl.text = Constants.MESSAGE.LOADING_DATA
        
        lbl.font = UIFont.init(name: "FertigoPro-Regular", size: 17)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.5
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 3
        lbl.textColor = #colorLiteral(red: 0.8, green: 0.03921568627, blue: 0.003921568627, alpha: 1)
        addSubview(lbl)
        
        
        btn.setBackgroundImage(#imageLiteral(resourceName: "ic_reload"), for: .normal)
//        btn.setTitle("Reload", for: .normal)
      
        
    }
    func Hide()  {
        isHidden = true
    }
    // "TryAgain" == internet connection not
    // "EmptyList" == Api Fail
    // ""no_connection"" == response fail
    func UpdateLbl(text : String)  {
        lbl.text = text
        animationView.frame = CGRect(x: 45, y: 0, width: 150, height: 150)

        if tag == 111 || lbl.text == Constants.MESSAGE.SOMETHING_Wrong{
           // animationView.setAnimation(named: "EmptyList")
          //  animationView.animation = Animation(
        }
      
       else if lbl.text == Constants.MESSAGE.INTERNET_LOST{
            animationView.frame = CGRect(x: 45, y: 0, width: 150, height: 150)

          //  animationView.setAnimation(named: "TryAgain")
        }
        else{
            animationView.frame = CGRect(x: 25, y: 0, width: 200, height: 200)

            //animationView.animation

        }
        addSubview(animationView)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        addSubview(btn)
        bringSubviewToFront(btn)

    }
    static func openDialingScreen(parent:UIViewController){
    }
    
}
