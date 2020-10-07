//
//  DatePickerViewController.swift
//  Zfood-User
//
//  Created by bhavya on 8/28/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
protocol ProtocolDateTime {
    func selectedTime(value:String)
}
class DatePickerViewController: UIViewController {

    @IBOutlet weak var mainTopView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var viewTopBar: UIView!
    var delegate : ProtocolDateTime?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
viewTopBar.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        mainTopView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleback(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func handleDone(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DATE_FORMAT.datePickerTime
        GloDeliveryTime = TimeFormat().DateAfter(min: "0")
        self.dismiss(animated: true) {
            let dateStr = formatter.string(from: self.datePicker.date)
            self.delegate?.selectedTime(value: dateStr)
        }
        
    }
    @IBAction func handleDatePicker(_ sender: Any) {
        
    }
    
  
}
