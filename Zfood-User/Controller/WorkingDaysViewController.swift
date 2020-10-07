//
//  WorkingDaysViewController.swift
//  Zfood-User
//
//  Created by bhavya on 5/18/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class WorkingDaysViewController: UIViewController {

    @IBOutlet weak var lblMonday: UILabel!
    
    @IBOutlet weak var lblSat: UILabel!
    @IBOutlet weak var lblFriday: UILabel!
    @IBOutlet weak var lblThus: UILabel!
    @IBOutlet weak var lblWed: UILabel!
    @IBOutlet weak var lblTuesday: UILabel!
    @IBOutlet weak var lblSunday: UILabel!
    var detailChef : ChefInfo?
    var avaibility = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDetail()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func addDetail(){
        if avaibility == ""{
            return
        }
        
        if let daysArr = self.avaibility.components(separatedBy: ",") as? [String]{
            if daysArr.count != 0{
                if daysArr.contains("1"){
                    self.lblMonday.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                }else{
                      self.lblMonday.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                }
                if daysArr.contains("2"){
                                   self.lblTuesday.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblTuesday.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
                if daysArr.contains("3"){
                                   self.lblWed.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblWed.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
                if daysArr.contains("4"){
                                   self.lblThus.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblThus.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
                if daysArr.contains("5"){
                                   self.lblFriday.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblFriday.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
                if daysArr.contains("6"){
                                   self.lblSat.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblSat.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
                if daysArr.contains("7"){
                                   self.lblSunday.backgroundColor = #colorLiteral(red: 0.2783386707, green: 0.5934699178, blue: 0.04843180627, alpha: 1)
                               }else{
                                     self.lblSunday.backgroundColor = #colorLiteral(red: 0.8912664056, green: 0.04162541777, blue: 0.3229057789, alpha: 1)
                               }
            }
        }
    }
}
