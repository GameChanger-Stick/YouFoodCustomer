
import UIKit

class SeparateParams: NSObject {
    
    class func separateParamsForMethod(method : String ,responseData : NSDictionary)-> AnyObject {
        if method == methodName.PROFILE_UPLOAD {
            return separateParamsForUserProfilePictureUpload(data: responseData)
        }else if method == methodName.TASK_ACTIVITY_FILE_UPLOAD_URL {
            return separateParamsForTaskActivityFileUpload(data: responseData)
        }else {
            return "Nothing" as AnyObject
        }
    }
    
    class func separateParamsForUserProfilePictureUpload(data : NSDictionary)-> AnyObject{
        print(data)
        return data as AnyObject
    }
    
    class func separateParamsForTaskActivityFileUpload(data : NSDictionary)-> AnyObject{
        print(data)
        return data as AnyObject
    }
    
}
