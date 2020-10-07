import Foundation
import UIKit
//Extension SignUp
class ImageController{
    //Show action Sheet
    func CHANGE_IMAGE(picker:UIImagePickerController,viewcontroller:UIViewController){
        let alert:UIAlertController=UIAlertController(title: "SELECT IMAGE", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "CAMERA", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                picker.sourceType = UIImagePickerController.SourceType.camera
                viewcontroller.present(picker, animated: true, completion: nil)
            }
            else
            {
                picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                if UIDevice.current.userInterfaceIdiom == .phone
                {
                    viewcontroller.present(picker, animated: true, completion: nil)
                }
            }
            
        }
        let GalleryAction = UIAlertAction(title: "GALLERY", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                viewcontroller.present(picker, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
            
        }
        // Add the actions
        picker.allowsEditing = true
        
        alert.addAction(cameraAction)
        alert.addAction(GalleryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            viewcontroller.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func converToData(_ image:UIImage) -> Data{
        let imageData:NSData = image.pngData()! as NSData
        return imageData as Data
    }
}
//MARK- Delegate ImagePicker
extension ZUCProfileViewController : UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate{
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
          return
            dismiss(animated: true, completion: nil
            )
        }
        self.imgProfile.image = selectedImage
         UploadImage()
        dismiss(animated: true, completion: nil
        )
    }
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
////////////////////////////////////////////////////////////////////////////////////



extension UIImage {
    
    func addShadow(blurSize: CGFloat = 6.0) -> UIImage {
        
        let shadowColor = UIColor(white:0.0, alpha:0.8).cgColor
        
        let context = CGContext(data: nil,
                                width: Int(self.size.width + blurSize),
                                height: Int(self.size.height + blurSize),
                                bitsPerComponent: self.cgImage!.bitsPerComponent,
                                bytesPerRow: 0,
                                space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        context.setShadow(offset: CGSize(width: blurSize/2,height: -blurSize/2),
                          blur: blurSize,
                          color: shadowColor)
        context.draw(self.cgImage!,
                     in: CGRect(x: 0, y: blurSize, width: self.size.width, height: self.size.height),
                     byTiling:false)
        
        return UIImage(cgImage: context.makeImage()!)
    }
}










