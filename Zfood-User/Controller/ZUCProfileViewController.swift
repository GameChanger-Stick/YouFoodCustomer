//
//  ZUCProfileViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/20/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces

class ZUCProfileViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtAddress: UILabel!
    var lat = ""
    var lng = ""
    var imgStr = String()
    var register : RegisterPresenter?
    var picker = UIImagePickerController()
    @IBOutlet weak var txtEmail: UITextField!
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
         addData()
        // Do any additional setup after loading the view.
    }
    func addData(){
        self.txtFirstName.text = currentUser?.info.firstName
        self.txtLastName.text = currentUser?.info.lastName
        self.txtEmail.text = currentUser?.info.userEmail
        self.txtPhone.text = currentUser?.info.mobile
        self.txtAddress.text = currentUser?.info.profileAddress
        imgStr = currentUser?.info.imgProfile ?? ""
        register = RegisterPresenter(delegate: self, viewcontroler: self)
        self.imgProfile.getImage(url: currentUser?.info.imgProfile ?? "")
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func handleProfile(_ sender: Any) {
        register?.editProfile(firstName: self.txtFirstName.text!, lastNAme: self.txtLastName.text!, email: self.txtEmail.text!, phone: self.txtPhone.text!,img: self.imgStr, lnt: GloLat, lng: GloLng, Profile_Address: GloAddress1)
    }
    
    @IBAction func handleAddAddress(_ sender: Any) {
        openGooglePlace()
        
    }
    @IBAction func handleUploadImage(_ sender: Any) {
        ImageController().CHANGE_IMAGE(picker: picker, viewcontroller: self)

        
    }
    
    func openGooglePlace(){
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.addressComponents.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))!
        autocompleteController.placeFields = fields
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
       // filter.country = "USA"
       let searchBound = getCoordinateBounds(latitude: CLLocationDegrees(userLAT), longitude: CLLocationDegrees(userLNG), distance: 3.45)
     autocompleteController.autocompleteBounds = searchBound
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    func getCoordinateBounds(latitude:CLLocationDegrees ,
                             longitude:CLLocationDegrees,
                             distance:Double = 0.001)->GMSCoordinateBounds{
        let center = CLLocationCoordinate2D(latitude: latitude,
                                            longitude: longitude)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + distance, longitude: center.longitude + distance)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - distance, longitude: center.longitude - distance)

        return GMSCoordinateBounds(coordinate: northEast,
                                   coordinate: southWest)

    }
    @IBAction func handleBack(_ sender: Any) {
        if type == "1"{
        self.dismiss(animated: true) {
            return
        }
        }else{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //    appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
        appDelegate.drawerController.open(.left, animated: true, completion: nil)
        }
    }
    func UploadImage(){
        let dict = ["type":"1"]
       self.view.pleaseWait()
        APIServices().UploadImage(params: dict, viewController: self, loader: true, image: imgProfile.image!) { (result, error) in
          self.view.clearAllNotice()
            self.imgStr = result?.value(forKey: "ImgUrl") as! String
            
            self.register?.editProfile(firstName: self.txtFirstName.text!, lastNAme: self.txtLastName.text!, email: self.txtEmail.text!, phone: self.txtPhone.text!,img: self.imgStr, lnt: GloLat, lng: GloLng, Profile_Address: GloAddress1)
            
        }
    }
    

    
}
extension ZUCProfileViewController : RegistrationDelegate{
    func didSucces() {
        self.showSuccess(msg: "Profile updated")
    }
    
    func didFailWithError(error: String) {
        self.showError(msg: error)
    }
    
}
extension ZUCProfileViewController : GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        userLAT = Double(place.coordinate.latitude)
        userLNG = Double(place.coordinate.longitude)
        GloLat = "\(userLAT)"
        GloLng = "\(userLNG)"
        for obj in place.addressComponents!{
            if obj.types[0] == "route"{
                SelectedLocality = obj.name
            }
            if obj.types[0] == "country"{
               // self.lblAddress2.text = obj.name
                       }
        }
        Selectedaddress = place.formattedAddress!
        GloAddress1 = Selectedaddress
        self.txtAddress.text = Selectedaddress
       // self.gotoToLocation(location: place.coordinate)
        dismiss(animated: true, completion: nil)
        // self.presenter?.getCart()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
