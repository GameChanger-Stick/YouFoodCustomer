//
//  chatVC.swift
//  The Shop
//
//  Created by Mukesh on 04/03/19.
//  Copyright © 2019 Pal Singh. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView
var presentView = ""
class ChatViewController: CommonViewController {
    var cellChat = "ChatListTableViewCell"
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var noMsg: UILabel!
    var inboxArray : NSMutableArray = []
    var keys = [String]()
    //@IBOutlet var viewNomsg: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
   //self.viewNomsg.isHidden = false
        tableView.register(UINib(nibName: cellChat, bundle: nil), forCellReuseIdentifier: cellChat)
        tableView.estimatedRowHeight = 200
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.Inbox()
        
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
   
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxArray.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///
        let cell = tableView.dequeueReusableCell(withIdentifier: cellChat, for: indexPath) as! ChatListTableViewCell
        //self.viewNomsg.isHidden = true
        cell.selectionStyle = .none
        cell.selectionStyle = .none
        let tempDict = self.inboxArray.object(at: indexPath.row) as! NSDictionary
        let tempChatData = tempDict.value(forKey: "chatData") as! NSDictionary
        print(tempChatData)
        for (key,value) in tempChatData{
            if key as! String != self.userDetail?.inUserId!{
                cell.nameLbl.text = (value as! NSDictionary).value(forKey: "name") as! String
                if let userImage = (value as! NSDictionary).value(forKey: "profile_image") as? String{
//                    if userImage != ""{
//                        ImageCacheController.sharedInstance.downloadImage(imageURL: GlobalConstants.Path.baseUrlForMedia + userImage, imageView:  cell.imgV, placeholderImage: #imageLiteral(resourceName: "logo"))}
                    
                }
                break
            }
        }
        if let tempChat = tempDict.value(forKey: "chat") as? NSDictionary{
            for (key,value) in tempChat{
                if let values = value as? NSDictionary{
                    if values.value(forKey: "image") as! Bool == true{
                        cell.lblmsg.text = "image"
                        break
                    }else{
                        cell.lblmsg.text = values.value(forKey: "message") as! String
                        break
                    }
                    
                }
            }
        }
        
        return cell
        
    }
   
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tempDict = self.inboxArray.object(at: indexPath.row) as! NSDictionary
        print(tempDict)
        var idsArr = [String]()
        var FinalId : String = ""
        var auserName : String = ""
        if let chatData = tempDict.value(forKey: "chatData") as? NSDictionary{
            for (key,value) in chatData{
                if key as! String != self.userDetail?.inUserId{
                    anotherUserId = key as! String
                    if let values = value as? NSDictionary{
                        auserName = values.value(forKey: "name") as! String
                    }
                }
                idsArr.append(key as! String)
            }
            if idsArr.count == 2{
                if idsArr[0].IntValueNIL() != nil {
                    let id1 = idsArr[0]
                    let id2 = idsArr[1]
                        FinalId = "\(id1)_\(id2)"
                }else{
                    let id1 = idsArr[0]
                    let id2 = idsArr[1]
                        FinalId = "\(id2)_\(id1)"
                }
               
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SingleChatDetailViewController") as! SingleChatDetailViewController
           // vc.isMsgBlastVC = false
            vc.UserName =  auserName
            vc.UserId = (self.userDetail?.inUserId)!
            vc.chatID = FinalId
            vc.ChatType = "OneByOne"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.deleteSingleChat(groupID: self.keys[indexPath.row])
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor =  UIColor.darkGray
        
        return [deleteButton]
    }
    }


