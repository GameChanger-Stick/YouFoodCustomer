//
//  ZFUFilterVC.swift
//  Zfood-User
//
//  Created by Mukesh on 30/07/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//
import UIKit
import RangeSeekSlider

protocol FilterProtocol {
    func fiterValue()
}
class ZFUFilterVC: UIViewController {

    @IBOutlet weak var priceRange: RangeSeekSlider!
    @IBOutlet weak var imgLowtoHigh: UIImageView!
    @IBOutlet weak var imgVagan: UIImageView!
    @IBOutlet weak var imgHightoLow: UIImageView!
    @IBOutlet weak var imgkit0: UIImageView!
    @IBOutlet weak var imgJain: UIImageView!
     @IBOutlet weak var imgHalal: UIImageView!
    var deletegate : FilterProtocol?
  var dishType =  ["0","1","2","3"]
    var chkImg = #imageLiteral(resourceName: "radio_button_selected")
    var unChkImg = #imageLiteral(resourceName: "radio_button")
    override func viewDidLoad() {
        super.viewDidLoad()
       
        priceRange.delegate = self
SetBackButton()
        if  foodType == "1"{
            allFoodtypeUncheck()
            self.imgVagan.image = self.chkImg
        }else if foodType == "2"{
            allFoodtypeUncheck()
            self.imgHalal.image = chkImg
        }else if foodType == "3"{
            allFoodtypeUncheck()
            self.imgJain.image = chkImg
        }else if foodType == "0"{
            allFoodtypeUncheck()
            self.imgkit0.image = chkImg
        }
        if maxPrice != ""{
            let max = Int(maxPrice ) ?? 100
              let min = Int(minPrice) ?? 0
           self.priceRange.selectedMaxValue = CGFloat(max)
            self.priceRange.selectedMinValue = CGFloat(min)
        }
    }
    
    @IBAction func handleMAxPrice(_ sender: RangeSeekSlider) {
        
    }
    //     [dishTypes addObject:@"Keto"];
//    [dishTypes addObject:@"Vegan"];
//    [dishTypes addObject:@"Halal"];
//    [dishTypes addObject:@"Jain"];
    func SetBackButton()  {
        title = Constants.VIEW_TITLE.REfine
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "back_arrow_icon"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(self.backButton), for: .touchDown)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setLeftBarButton(item1, animated: true)
        let reset = UIButton(type: .custom)
        reset.setTitle("RESET", for: .normal)
        reset.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        reset.addTarget(self, action: #selector(self.resetButton), for: .touchDown)
        let item2 = UIBarButtonItem(customView: reset)
        self.navigationItem.setRightBarButton(item2, animated: true)
        ////
    }
    @objc func backButton()  {
        dismiss(animated: true) {
            // self.UploadProfile()
        }
    }
    @objc func resetButton()  {
        self.priceRange.selectedMaxValue = 100
        self.priceRange.selectedMinValue = 0
        maxPrice = ""
        minPrice = ""
        foodType = ""
        self.dismiss(animated: true) {
            self.deletegate?.fiterValue()
        }
    }
    
    func allFoodtypeUncheck(){
        self.imgJain.image = #imageLiteral(resourceName: "radio_button")
        self.imgHalal.image = #imageLiteral(resourceName: "radio_button")
        self.imgkit0.image = #imageLiteral(resourceName: "radio_button")
        self.imgVagan.image = #imageLiteral(resourceName: "radio_button")
    }
    
    @IBAction func handleVegan(_ sender: Any) {
         foodType = "1"
       allFoodtypeUncheck()
             self.imgVagan.image = self.chkImg
    }
    
    @IBAction func handleketo(_ sender: Any) {
        foodType = "0"
       allFoodtypeUncheck()
             self.imgkit0.image = chkImg
    }
    
    @IBAction func handlehalal(_ sender: Any) {
        foodType = "2"
       allFoodtypeUncheck()
             self.imgHalal.image = chkImg
       
    }
    
    @IBAction func handleJain(_ sender: Any) {
         foodType = "3"
     allFoodtypeUncheck()
         self.imgJain.image = chkImg
    }
   
    @IBAction func handleHightoLow(_ sender: Any) {
        self.imgHightoLow.image = #imageLiteral(resourceName: "radio_button_selected")
        self.imgLowtoHigh.image = #imageLiteral(resourceName: "radio_button")
    }
    
    @IBAction func handleLowtoHigj(_ sender: Any) {
        self.imgLowtoHigh.image = #imageLiteral(resourceName: "radio_button_selected")
        self.imgHightoLow.image = #imageLiteral(resourceName: "radio_button")
    }
    
    @IBAction func handleApplyFilter(_ sender: Any) {
        self.dismiss(animated: true) {
            self.deletegate?.fiterValue()
        }
    }
}
extension ZFUFilterVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        let max = Int(maxValue)
        let min = Int(minValue)
        minPrice = String(min)
        maxPrice = String(max)
          print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
    }
}
