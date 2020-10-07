
import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
//import NVActivityIndicatorView
extension SingleChatDetailViewController{
    //MARK: - SendMessageSingleChat
    func sendMessage(messageFromUser : String,image : Bool,message : String,imageUrl:String) {
        let chattingRef3 : FIRDatabaseReference? =  FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        print(chatID)
        let itemRef = chattingRef3?.child("privateChats").child(chatID).child("chat").childByAutoId()
        let TimeStampstr = String(Date().ticks())
        let timeStr :String = self.CurentDate()
        
        let messageItem = [
            "messageFromUser" : UserId,
            "image" : image,
            "message" : message,
            "time" : TimeStampstr,
            "timeStr":timeStr,
            "imageUrl" : imageUrl
            ] as [String : Any]
        
        MessageIDForLastMessage = itemRef?.key as! String
        print(messageItem)
        
        itemRef?.updateChildValues(messageItem, withCompletionBlock: { (error, response) in
            
            if (error != nil)
            {
                print("error")
            }
            else
            {
                self.txtEnterMsg.text = ""
                print("complete")
            }
        }
        )
    }
    //For image
//    func imageUpload(data : Data){
//        //self.showLoading()
//        let metaData = FIRStorageMetadata()
//        metaData.contentType = "image/png"
//        let TimeStamp = String(format:"%.0f", NSDate().timeIntervalSince1970 * 1000)
//        let ImagesUrl = GlobalConstants.FireBaseData.storageUrl + TimeStamp
//        let storageRefphotos : FIRStorageReference = FIRStorage.storage().reference(forURL: ImagesUrl)
//
//        storageRefphotos.put(data as Data, metadata: metaData){(metaData2,error) in
//            if error != nil{
//              //  self.hideLoading()
//                print("error")
//                return
//            }else{
//                storageRefphotos.downloadURL(completion: { (url, error) in
//                    if let urlText = url?.absoluteString{
//                        let strURL = urlText
//                        print(strURL)
//                     //   self.hideLoading()
////                        self.sendMessage(FromUserId:                  (DefaultsHelper.getUser()?.id)!
////                            , Image: true, Message: strURL, time: String(format:"%.0f", NSDate().timeIntervalSince1970 * 1000), timeStr: TimeStamp)
//                        self.sendMessage(messageFromUser: (self.userDetail?.inUserId, image: true, message: strURL, imageUrl: strURL)
//                    }
//                })
//
//            }
//        }
//    }
    @objc func chageUserToOffline(){
        let chattingRef3 : FIRDatabaseReference? =  FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        print(chatID)
        if chatID != ""{
            if UserId != ""{
        let itemRef = chattingRef3?.child("privateChats").child(chatID).child("chatData").child(UserId)
        itemRef?.updateChildValues(["online":false])
            }}
    }
   
    
    func chageUserOnline(to status:Bool){
//        let chattingRef3 : FIRDatabaseReference? =  FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
//        print(chatID)
//        let itemRef = chattingRef3?.child("privateChats").child(chatID).child("chatData").child(UserId)
//        itemRef?.updateChildValues(["online":status])
    }
    func isOnline(userid:String){
        var users = [[String:Any]]()
        var online = Bool()
        var messageRef1TimeStampGet : FIRDatabaseReference
        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        var newMessageRefHandleTImeStampHandler : FIRDatabaseHandle
        messageRef1TimeStampGet = chattingRef1.child("privateChats").child(chatID).child("chatData")
        let messageQuery1 = messageRef1TimeStampGet.queryLimited(toLast: 1000)
        newMessageRefHandleTImeStampHandler = messageQuery1.observe(.childAdded, with: { (snapshot) -> Void in
            if let messageData = snapshot.value as? [String:Any]{
                print(messageData)
                users.removeAll()
                users.append(messageData)
                if users.count != 0{
                    for obj in users{
                        if  (obj as NSDictionary).value(forKey: "id") as! String == anotherUserId{
                            if (obj as NSDictionary).value(forKey: "online") as! Bool{
                                online = true
                                
                                return
                            }
                            else{
                                online = false
                               
                                return
                            }
                        }
                    }
                     self.sendNoti(userid: userid, in_chef_id: anotherUserId, title: self.UserName, des: self.txtEnterMsg.text!, type: "2")
                }

            }
            
        })
       
    }
    func sendNoti(userid:String,in_chef_id:String,title:String,des:String,type:String){
"//http://3.94.1.254/mobile/msgNotification?title=title&description=desc&type=1&user_id=21&in_chef_id="
        let param = ["user_id":currentUser?.info.inUserId ?? "","msg":des,"type":"2","in_chef_id":in_chef_id] as [String : Any]
              APIServices().OfineMsgNotification(params: param, viewController: self, loader: false) { (data, error) in
                  if data != nil{
                     // self.arrNotification = data
                     // self.tableView.reloadData()
                  }else{
                    //  self.arrNotification?.data.removeAll()
                               //      self.lblNoNotification.isHidden = false
                                 //    self.tableView.reloadData()
                  }
              }
          
    }
    func todayDateINFormat() -> String{
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmmssZ"
        let result = formatter.string(from: date)
        
        let dateReturn : String = String( result)
        return dateReturn
    }
    
    func CurentDate() -> String{
        //"Mar 18, 07:42 PM"
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DATE_FORMAT.datePickerTime90
        let result = formatter.string(from: date)
        
        let dateReturn : String = String( result)
        return dateReturn
    }
    

    //Mark: - TimeFormat ForChat
    func timeFormatchat(formatDate : String) -> String {
        let str_time = formatDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMddHHmmssZ"
        let date = dateFormatter.date(from: str_time)
        let formatter = DateFormatter()
        //   formatter.dateFormat = "dd MMM HH:mm a"
        formatter.dateFormat = "dd MMM HH:mm"
        let result = formatter.string(from: date!)
        print(result)
        
        return result
    }
    func GetChatUserData()
    {
        var messageRef1TimeStampGet : FIRDatabaseReference
        let chattingRef1 : FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        var newMessageRefHandleTImeStampHandler : FIRDatabaseHandle
        messageRef1TimeStampGet = chattingRef1.child("privateChats").child(chatID).child("chatData")
        let messageQuery1 = messageRef1TimeStampGet.queryLimited(toLast: 1000)
        newMessageRefHandleTImeStampHandler = messageQuery1.observe(.value, with: { (snapshot) -> Void in
            print(snapshot)
            self.OneToOneChatUserData = snapshot.value as! NSDictionary
            print(self.OneToOneChatUserData)
            
        })
    }
    func InboxMessageGet()
    {
        self.chatArray.removeAllObjects()
        var messageRef1TimeStampGet : FIRDatabaseReference
        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        var newMessageRefHandleTImeStampHandler : FIRDatabaseHandle
        messageRef1TimeStampGet = chattingRef1.child("privateChats").child(chatID).child("chat")
        let messageQuery1 = messageRef1TimeStampGet.queryLimited(toLast: 1000)
        newMessageRefHandleTImeStampHandler = messageQuery1.observe(.childAdded, with: { (snapshot) -> Void in
            if let messageData = snapshot.value as? NSDictionary{
            print(messageData)
                self.chatArray.add(messageData)
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: NSIndexPath.init(row: self.chatArray.count - 1, section: 0) as IndexPath, at: .bottom, animated: false)
                
                let index = IndexPath.init(row: self.chatArray.count - 1, section: 0)
                self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
            }
        })
    }
}
extension ChatViewController{
    
    func Inbox(){
        //presentIndicator()
       // self.noMsg.isHidden = false
        var messageRef1TimeStampGet : FIRDatabaseReference
        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        var newMessageRefHandleTImeStampHandler : FIRDatabaseHandle
        
        messageRef1TimeStampGet = chattingRef1.child("privateChats")
        let messageQuery1 = messageRef1TimeStampGet.queryLimited(toLast: 1000)
        newMessageRefHandleTImeStampHandler = messageQuery1.observe(.value, with: { (snapshot) -> Void in
           // dismissIndicator()
            if  let messageData = snapshot.value as? NSDictionary{
            print(messageData.allKeys)
            let allKeys = messageData.allKeys as! NSArray
            self.inboxArray.removeAllObjects()
                self.keys.removeAll()
            for i in 0 ... allKeys.count - 1 {
                let key = allKeys.object(at: i) as! String
                let iduser = self.userDetail?.inUserId!
                if key.range(of: iduser! ) != nil {
                    self.inboxArray.add(messageData.value(forKey: key) as! NSDictionary)
                    self.keys.append(allKeys[i] as! String)
                    print(self.inboxArray)
                }
            }
                if self.inboxArray.count == 0{
                   self.noMsg.isHidden = false
                }else{
                  self.noMsg.isHidden = true
                }
            
                self.tableView.reloadData()
            }else{
                self.inboxArray.removeAllObjects()
                  self.noMsg.isHidden = false
                self.tableView.reloadData()
            }
        })
        
    }

    func timeFormatchat(formatDate : String) -> String {
        let str_time = formatDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMddHHmmssZ"
        let date = dateFormatter.date(from: str_time)
        print(date!)
        let formatter = DateFormatter()
        //   formatter.dateFormat = "dd MMM HH:mm a"
        formatter.dateFormat = "dd MMM HH:mm"
        let result = formatter.string(from: date!)
        print(result)
        return result
    }
}
extension NotificationViewController{
    func CreateChat(GroupID : String,ChatData : NSDictionary){
        let chattingRef3 : FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
       
        let messageItem : NSDictionary = ChatData
        print(messageItem)
         self.noticeOnlyText("Loading...")
        let itemRef = chattingRef3.child("privateChats").child(GroupID).child("chatData")
        itemRef.updateChildValues(messageItem as! [AnyHashable : Any], withCompletionBlock: { (error, response) in
            if (error != nil)
            {
                print("error")
            }
            else{
                print("complete")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let ChatViewController = storyBoard.instantiateViewController(withIdentifier: "SingleChatDetailViewController") as! SingleChatDetailViewController
                ChatViewController.chatID = GroupID
                ChatViewController.ChatType = "OneByOne"
                ChatViewController.UserName = self.userDetail!.firstName
                ChatViewController.UserId = self.userDetail!.inUserId
               let nav = UINavigationController(rootViewController: ChatViewController)
                nav.navigationBar.isHidden = true
                nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            }
        }
        )
    }
}
//extension ChatViewController{
//
//    func timeFormatchat(formatDate : String) -> String {
//        let str_time = formatDate
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyMMddHHmmssZ"
//        let date = dateFormatter.date(from: str_time)
//        print(date!)
//        let formatter = DateFormatter()
//        //   formatter.dateFormat = "dd MMM HH:mm a"
//        formatter.dateFormat = "dd MMM HH:mm"
//        let result = formatter.string(from: date!)
//        print(result)
//
//        return result
//    }
//
//    func Inbox(){
//        presentIndicator()
//        var messageRef1TimeStampGet : FIRDatabaseReference
//        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: GlobalConstants.FireBaseData.chatUrl)
//        var newMessageRefHandleTImeStampHandler : FIRDatabaseHandle
//        messageRef1TimeStampGet = chattingRef1.child("privateChats")
//        let messageQuery1 = messageRef1TimeStampGet.queryLimited(toLast: 1000)
//        newMessageRefHandleTImeStampHandler = messageQuery1.observe(.value, with: { (snapshot) -> Void in
//
//dismissIndicator()
//            if  let messageData = snapshot.value as? NSDictionary{
//            print(messageData.allKeys)
//            let allKeys = messageData.allKeys as! NSArray
//
//            self.inboxArray.removeAllObjects()
//            self.keys.removeAll()
//            for i in 0 ... allKeys.count - 1 {
//                let key = allKeys.object(at: i) as! String
//                if key.range(of: (DefaultsHelper.getUser()?.id)!) != nil {
//                    self.inboxArray.add(messageData.value(forKey: key) as! NSDictionary)
//                    self.keys.append(allKeys[i] as! String)
//                    print(self.inboxArray)
//                }
//            }
//
//            self.tableView.reloadData()}
//
//        })
//
//    }
//}
extension Date {
    func ticks() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
}
}
//extension inboxClientVC{
//    func deleteSingleChat(groupID:String){
//        print(inboxArray)
//        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: GlobalConstants.FireBaseData.chatUrl)
//        var _ : FIRDatabaseHandle
//        var messageRef1TimeStampGet : FIRDatabaseReference
//
//        messageRef1TimeStampGet = chattingRef1.child("privateChats")
//        let ref1 = messageRef1TimeStampGet.child(groupID)
//
//        ref1.removeValue { error, _ in
//            self.Inbox()
//            print(error)
//        }
//    }
//
//
//    static func remove(child: String) {
//
//
//
//
//    }
//}
extension ChatViewController{
    func deleteSingleChat(groupID:String){
        print(inboxArray)
        let chattingRef1: FIRDatabaseReference = FIRDatabase.database().reference(fromURL: Constants.FireBaseData.chatUrl)
        var _ : FIRDatabaseHandle
        var messageRef1TimeStampGet : FIRDatabaseReference
        
        messageRef1TimeStampGet = chattingRef1.child("privateChats")
        let ref1 = messageRef1TimeStampGet.child(groupID)
        
        ref1.removeValue { error, _ in
            self.Inbox()
            print(error)
        }
    }
    
    
    static func remove(child: String) {
        
        
        
        
    }
}


