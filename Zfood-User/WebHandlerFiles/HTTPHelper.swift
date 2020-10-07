
import UIKit
import Alamofire
class HTTPHelper: NSObject, NSURLConnectionDelegate {
    var window : UIWindow?
    func httpPostMethod(strURL : String ,params : [String:Any],view:UIViewController, completion: @escaping (_ result: AnyObject?, _ error: String)->()) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() {
            view.clearAllNotice()
            view.pleaseWait()
            if UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) != nil{
                           loginToken = UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) as! String
                       }
                       if UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) != nil{
                           userIDHeadder = (currentUser?.info.inUserId)!
                       }
            let hedder = ["user-id":userIDHeadder,"Authorization":loginToken,"timezone":TimeZone.current.identifier]

            let urlString = strURL
            Alamofire.request(urlString, method: .post, parameters: params as? Parameters , headers: hedder).validate(contentType: ["application/json","text/html"]).responseJSON { (response:DataResponse<Any>) in
                view.clearAllNotice()
                if  let rewsponse = response.response?.statusCode{
                                       if rewsponse == 401{
                                                   let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                   let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                                                       let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                           nav.navigationBar.isHidden = true
                                           nav.modalPresentationStyle = .fullScreen
                                           UserDefaults.standard.removeObject(forKey: Constants.userDefaults.userDetail)
                                         currentUser = nil
                                                               UserDefaults.standard.removeObject(forKey: Constants.userDefaults.usrToken)
                                                   view.present(nav, animated: false, completion: nil)
                                           return
                                       }
                                   }
                switch response.result{
                case .success(_):
                    if let JSON = response.result.value {
                        if JSON is NSArray {
                            let dict = ["result":JSON]
                            completion(dict as AnyObject,"")
                        }else{
                            completion(response.result.value as AnyObject?, "")
                        }
                    }
                    break
                case .failure(_):
                    if (response.result.error != nil) {
                        view.view.makeToast("Server not responding")
                        // completion(JSON as AnyObject, "")
                    }
                    break
                }
            }
        } else {
            view.view.makeToast("Please check internet connection")
            // completion(JSON as AnyObject, "")
        }
    }
    
    func httpGetResponse(strURL: String, params : [String:Any]?,view:UIViewController,loader:Bool, completion: @escaping (_ result: AnyObject?, _ error: String?)->()){
        view.clearAllNotice()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() {
            if loader{view.pleaseWait()}
            var paramsSTR = ""
            if params != nil{
                paramsSTR = (params!.compactMap({ (key, value) -> String in
                    return "\(key)=\(value)"
            }) as Array).joined(separator: "&")
            }
            let requestString = strURL + paramsSTR
            if UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) != nil{
                loginToken = UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) as! String
            }
            if UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) != nil{
                userIDHeadder = (currentUser?.info.inUserId)!
            }
 let hedder = ["user-id":userIDHeadder,"Authorization":loginToken,"timezone":TimeZone.current.identifier]
            let encoded = requestString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let url = URL(string: encoded ?? "")
            print(requestString)
            Alamofire.request(url ?? "", method: .get, encoding: URLEncoding.default, headers: hedder)
                .responseJSON { response in
                   // DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                         view.clearAllNotice()
                   // }
                    if  let rewsponse = response.response?.statusCode{
                        if rewsponse == 401{
                            if  !isguest{
                                
                            
                                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "SelectTypeViewController") as! SelectTypeViewController
                                        let nav = UINavigationController(rootViewController: initialViewControlleripad)
                            nav.navigationBar.isHidden = true
                            nav.modalPresentationStyle = .fullScreen
                            UserDefaults.standard.removeObject(forKey: Constants.userDefaults.userDetail)
                                                UserDefaults.standard.removeObject(forKey: Constants.userDefaults.usrToken)
                                    view.present(nav, animated: false, completion: nil)
                                
                            return
                            
                            }}
                    }
                
                    
                    //response.response?.statusCode
                    switch response.result {
                    case .success:
                        if let JSON = response.result.value {
                            if JSON is NSArray {
                                let dict = ["result":JSON]
                                completion(dict as AnyObject, "")
                            }else {
                                completion(JSON as AnyObject, "")
                            }
                        }
                        break
                    case .failure:
                        if (response.result.error != nil) {
                            //view.view.makeToast("Server not responding")
                            // completion(JSON as AnyObject, "")
                        }
                        break
                    }
            }
        } else {
            view.view.makeToast("Please check internet connection")
            // completion(JSON as AnyObject, "")
        }
    }
    
    func UploadDataWithImage( Url: NSString, dict: NSDictionary, image : UIImage,imageKey : String , storyBoard : UIStoryboard , navigation : UIViewController, withCompletionHandler:@escaping (_ result:NSDictionary , _ Error : NSString , _ StatusCode : Int ) -> Void) {
        var url = "\(Url)"
        url = url.replacingOccurrences(of: " ", with: "%20")
        let image = image
        let imgData = image.jpegData(compressionQuality: 0.4)
        if UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) != nil{
                       loginToken = UserDefaults.standard.value(forKey: Constants.userDefaults.usrToken) as! String
                   }
                   if UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) != nil{
                       userIDHeadder = (currentUser?.info.inUserId)!
                   }
        let parameters = ["type": "1"] //Optional for extra parameter
          let hedder = ["user-id":userIDHeadder,"Authorization":loginToken,"timezone":TimeZone.current.identifier]
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: imageKey,fileName: "\(imageKey)/\(Int(NSDate().timeIntervalSince1970)).jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },to:url, headers: hedder)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        if JSON is NSDictionary{
                            
                              withCompletionHandler( JSON as! NSDictionary , Constants.API_ERROR_TYPE.Success as NSString, (response.response?.statusCode)!)
                        }
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }

}
