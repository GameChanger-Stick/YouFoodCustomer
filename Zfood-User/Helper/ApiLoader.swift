//
//  ApiLoader.swift
//  ClickPic
//
//  Created by Jaypreet on 04/05/18.
//  Copyright © 2018 jaipreet singh & Harpreet Singh. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ApiLoader : UIView {
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7455318921)
        let animationView = AnimationView(name: "loader")
            animationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            animationView.center = center
            animationView.contentMode = .scaleAspectFill
        
            addSubview(animationView)
            animationView.loopMode = .loop
            animationView.play()
    
    }
    func Show()  {
        isHidden = false
    }
    func Hide()  {
        isHidden = true
    }
    
    static func openDialingScreen(parent:UIViewController){
    }
    
}
