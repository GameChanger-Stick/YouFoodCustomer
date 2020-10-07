//  SingleChatDetail.swift
//  The Shop
//  Created by Mukesh on 08/03/19.
//  Copyright © 2019 Pal Singh. All rights reserved.

import UIKit
import IQKeyboardManagerSwift

var chatID = ""

var anotherUserId = ""
var UserTypeChat = ""
class SingleChatDetailViewController: CommonViewController {
    var UserId = String()
    ////a
    
    @IBOutlet var bottomViewSend: NSLayoutConstraint!
    @IBOutlet var widthplusBtn: NSLayoutConstraint!
    var UserName = ""
    var MessageIDForLastMessage : String = ""
    var chatArray : NSMutableArray = []
    var chatID : String = ""
    var ChatType : String = ""
    var OneToOneChatUserData : NSDictionary = [:]
    /////
    @IBOutlet var txtEnterMsg: TextField!
   
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    var lastContentOffset: CGFloat = 0
    var imagePicker = UIImagePickerController()
    @IBOutlet var tableView: UITableView!
    var starttouchY = CGFloat()
    var endTouchY = CGFloat()
    var status = ["1","3","0","1","3","1","0","4","0","0","0","1","0","1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
 self.chageUserOnline(to: false)
    }
    
    func setupUI(){
        IQKeyboardManager.shared.enable = false
        txtEnterMsg.returnKeyType = .done
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.chageUserToOffline),
            name:Notification.Name("onlinestatus"),
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    
        self.lbName.text = UserName
        panGesture.delegate = self
        tableView.register(UINib(nibName: "SenderTableViewCell", bundle: nil), forCellReuseIdentifier: "SenderTableViewCell")
        tableView.register(UINib(nibName: "ReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverTableViewCell")
            self.chageUserOnline(to: true)
            self.InboxMessageGet()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardSize:CGSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
       
        self.bottomViewSend.constant = keyboardSize.height
        if chatArray.count != 0{
            tableView.scrollToBottom()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
      
        self.bottomViewSend.constant = 0
        if chatArray.count != 0{
             tableView.scrollToBottom()
        }
    }
    
    @IBAction func hadlePanGesture(_ sender: UIPanGestureRecognizer) {
        ///if sender.
    }
    
    @IBAction func handleBackbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSendBtn(_ sender: Any) {
        if txtEnterMsg.text != ""{
            
                self.isOnline(userid: anotherUserId)
                self.sendMessage(messageFromUser: UserId, image: false, message: self.txtEnterMsg.text!, imageUrl: "")
            
        }
    }
    

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    @IBAction func handleAddImage(_ sender: Any) {
        //openActionSheet(sender as AnyObject)
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // did move up
            print("moveup")
            
            UIView.animate(withDuration: 5.0) {
              
                
            }}
        else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // did move down
            print("movedown")
            UIView.animate(withDuration: 5.0) {
               
            }
        } else {
            // didn't move
        }
    }
    
}

extension SingleChatDetailViewController:UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: self.view)
        starttouchY = location.y
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.sorted(by: { $0.timestamp < $1.timestamp }).last {
            let pt = touch.location(in: self.view)
            let distance = pt.y - self.starttouchY
            if distance > 10{
            }
            if distance < -10{
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
extension SingleChatDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return chatArray.count
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let tempDict = self.chatArray.object(at: indexPath.row) as! NSDictionary
            let FromUserID = tempDict.value(forKey: "messageFromUser") as! String
            let imageFileCheck = tempDict.value(forKey: "image") as! Bool
            if FromUserID == UserId{
                if imageFileCheck{
                    //this is my message so show message in right side
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                    cell.selectionStyle = .none
                    let imageUrl = tempDict.value(forKey: "imageUrl") as! String
                    
//                    if imageUrl != "" {
//                        ImageCacheController.sharedInstance.downloadImage(imageURL: imageUrl, imageView: cell.imgV, placeholderImage: #imageLiteral(resourceName: "barber_in_area_tut"))
//                    }
                    let unixTimestamp = tempDict.value(forKey: "timeStr") as! String
                    
                    cell.lblTime.text = unixTimestamp
                    return cell
                }else{
                    //this is my message so show message in right side
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell", for: indexPath) as! SenderTableViewCell
                    cell.selectionStyle = .none
                    cell.lblMsgSender.text = tempDict.value(forKey: "message") as? String
                    let unixTimestamp = tempDict.value(forKey: "timeStr") as! String
                    cell.lbltime.text = unixTimestamp
                    return cell
                }
                
            }else{
                if imageFileCheck{
                    //another person message
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                    cell.selectionStyle = .none
                    print(tempDict)
                    let imageUrl = tempDict.value(forKey: "imageUrl") as! String
//                    if imageUrl != "" {
//                        ImageCacheController.sharedInstance.downloadImage(imageURL: imageUrl, imageView: cell.imagV, placeholderImage: #imageLiteral(resourceName: "barber_in_area_tut"))
//                    }
                    let unixTimestamp = tempDict.value(forKey: "timeStr") as! String
                    cell.lblmsg.text = unixTimestamp
                    
                    return cell
                }else{
                    //another person message
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                    cell.selectionStyle = .none
                    cell.lblmsg.text = tempDict.value(forKey: "message") as? String
                    let unixTimestamp = tempDict.value(forKey: "timeStr") as! String
                    cell.lblTime.text = unixTimestamp
                    return cell
                }
            }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
}
extension SingleChatDetailViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

