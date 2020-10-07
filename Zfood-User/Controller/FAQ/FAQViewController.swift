//
//  FAQViewController.swift
//  Zfood-User
//  Created by bhavya on 2/12/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit

class FAQViewController: UIViewController {
    var  questons = ["Is there any service fee for using the app?",
    "What if I want the dish delivered to a different address and not my current location?",
    "How can I search for a dish?",
    "Is there any Delivery fee?",
    "How will I know when the order is ready.?",
    "What if I have to cancel an order?",
    "What if I need to order more of the same dish after placing an order?",
    "Can I pay for the order with cash when it is picked up or delivered?",
    "Can I pick up the order midway?",
    "Can I get allergy info for the dish?",
    "Can I get the nutrition facts or calorie info for the dish ordered?",
    "What if I need to cater to a party??",
    "What if I have a question that is not listed here?",
    "How can I provide my review?",
    "Where can I see my previous orders?",
    "What if I don’t like the dish I ordered?"]
    
    var answer = [["There is a nominal 5% fees to cover the credit card fees and services."],
    ["You will have an option to change the address on the Checkout screen."],
    ["You can use the Cuisines icon on the home page to bring up the list of chefs for those cuisines or even search by dish name. In case you don’t find what you are looking for please use the bell icon to send notification and there could be someone who can cook what you ask."],
    ["Yes. The delivery fee is set to Min. $3 for the first 5 miles. Every mile over 5 miles will be $1/mile."],
    ["The Chef will update the status as and when the  food gets Ready/Ready for Pick/Out For Delivery/Delivered. So you will get notification on each of these status changes."],
    ["Once the chef accepts the order, the order cannot be cancelled. Please review carefully before you place an order to avoid any confusion to the chefs."],
    ["You can chose the Repeat Order option on the previous Order when you go to the View Order. You can add more items or repeat the same items."],
    ["Currently we require that the payment be done through card."],
    ["The app will not manage or track pickup/delivery. You can chat with the Chef for     how/when to pick up the order."],
    ["The chef is required to provide those details on the dish. In case any info is missing or you need more details, the contact option will let you reach out to the Chef for any special requirements or allergy info of the dish."],
    ["The Chef is not required to provide those details but its upto the chef to provide as much details as possible. In any case you can contact the Chef for the nutrition facts and calorie info of the dish ordered"],
    ["You can send an Announcement (use the bell icon) through the app and the Chefs who are available will contact you through the chat box. There are options for the chefs to list an item as a catering quantity too."],
    ["Please use the Support section of the app to send us a query and we will respond asap or write to us directly support@thezfood.com"],["You will be able to review the chef once the order is complete"],
    ["All you order history can be found in the Orders tab from Main menu."],
    ["MiChef has no liability with the dish taste or quality. It is only a platform to connect the users to people who can cook for them. The taste might differ from person to person so its upto an individual’s discretion to review the feedback from other users and dish details before placing an order"]
    ]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "cell_FAQ", bundle: nil), forCellReuseIdentifier: "cell_FAQ")
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        // Do any additional setup after loading the view.
    }

    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension FAQViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answer[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return questons.count
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if questons[section].count >= 40{
//           return 100
//        }
//        return 50
//    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return questons[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewM = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: viewM.frame.width, height: viewM.frame.height))
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        lable.text = questons[section]
        lable.numberOfLines = 0
        lable.autoresizingMask = .flexibleHeight
        viewM.addSubview(lable)
        return viewM
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell_FAQ", for: indexPath) as! cell_FAQ
        cell.lblTitle.text = answer[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
