///////
protocol GotoChefDetailDelegate {
    func gotoChefDetail(id:String)
}
import UIKit
import FSCalendar
class CheckYourAvailabiltyVC: CommonViewController {

    @IBOutlet weak var heightViewCalendar: NSLayoutConstraint!
    
    @IBOutlet weak var view_Available: UIView!
    @IBOutlet weak var txtDate: UITextField!
    var openDays : String?
    var chefID = ""
    var selectedDate = Date()
    var delegate : GotoChefDetailDelegate?
    @IBOutlet weak var viewCalander: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 heightViewCalendar.constant = 220
        
        viewCalander.delegate = self
        
        self.view_Available.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //MARK:-Functions
    func calendarHideShow(){
        UIView.animate(withDuration: 0.2) {
                   if self.heightViewCalendar.constant == 220{
                       self.heightViewCalendar.constant = 0
                          }else{
                       self.heightViewCalendar.constant = 220
                          }
                          self.view.layoutIfNeeded()
               }
    }
    func DateAvailable(date:Date) -> Bool{
        if let arr = openDays?.components(separatedBy: ","){
            if arr.contains(date.getNumberToCompareDate()){
                return true
            }
        }
        return false
    }

    //MARK:-BUTTON ACTION
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func handleCalendar(_ sender: Any) {
       calendarHideShow()
    }
    
    @IBAction func HandecheckAvaibility(_ sender: Any) {
        if txtDate.text == ""{
            return
        }
        if self.DateAvailable(date: selectedDate){
            self.view_Available.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   self.dismiss(animated: false) {
                    self.delegate?.gotoChefDetail(id: self.chefID)
                    
                }
               }
        }else{
            self.alert("", message: "Chef not available on selected date")
        }
        
    }
}

extension CheckYourAvailabiltyVC : FSCalendarDelegate{
    //MARK:-FSCalendarDelegate

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
       calendarHideShow()
        self.selectedDate = date
           txtDate.text = date.getDateIn(formatt: Constants.DATE_FORMAT.ddmmyyyy)


    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let curDate = Date().addingTimeInterval(-24*60*60)
        
        if date < curDate {
            return false
        } else {
            return true
        }
    }
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
         let curDate = Date()
               
               if date < curDate {
                cell.appearance.titleDefaultColor = .lightGray
               } else {
                   cell.appearance.titleDefaultColor = .black
               }
    }
}
