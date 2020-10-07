//
//  FilterViewController.swift
//  Zfood-User
//
//  Created by bhavya on 3/5/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
protocol filterYearDelegate {
    func applyFilter(year:String ,type:String)
}
class FilterViewController: UIViewController {
    var dalegate : filterYearDelegate?
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnHideView: UIButton!
    var arrYears = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if arrYears.count != 0{
            
            self.lblSelectYear.text = arrYears[0]
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func handleHide(_ sender: Any) {
        self.dismiss(animated: true) {
                   
               }
    }
    
    
    @IBAction func handleDone(_ sender: Any) {
        if arrYears.count != 0{
            if dalegate != nil{
                dalegate?.applyFilter(year: self.lblSelectYear.text!, type: "5")
                self.dismiss(animated: true) {
                    
                }
            }else{
                self.dismiss(animated: true) {
                    
                }
            }
        }else{
            self.dismiss(animated: true) {
                
            }
        }
    }
    
    @IBOutlet weak var lblSelectYear: UILabel!
    
}
extension FilterViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.lblSelectYear.text = arrYears[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrYears[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
}
