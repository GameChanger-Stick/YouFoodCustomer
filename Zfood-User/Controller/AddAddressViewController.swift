//
//  AddAddressViewController.swift
//  Zfood-User
//
//  Created by bhavya on 9/2/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import GooglePlaces
class AddAddressViewController: UIViewController {
var lat = ""
    var lng = ""
    @IBOutlet weak var txtLandMark: UITextField!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UITextField!
    
    @IBOutlet weak var btnAdd: UIButton!
    var isEdit = Bool()
  //  var addDetail : InfoAddress?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetBackButton()
        EditAddress()
    }
    
    func EditAddress(){
        if isEdit{
       
//            self.lblName.text = addDetail?.name
//            self.lblAddress.text = addDetail?.address1
//            self.txtLandMark.text = addDetail?.address2
//            self.lat = addDetail!.lat
//            self.lng = addDetail!.lng
        }
        self.btnAdd.setTitle(isEdit ? "Update":"Add", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        view.layoutIfNeeded()
    }
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleAddAddress(_ sender: Any) {
        if lblName.text!.isEmpty{
            self.showError(msg: "Enter name")
            return
        }
        if lblAddress.text!.isEmpty{
            self.showError(msg: "Enter address")
            return
        }
        addAddress()
    }
    
    func SetBackButton()  {
        title = Constants.VIEW_TITLE.AddAddress
        let btn1 = UIButton(type: .custom)
        btn1.setImage(#imageLiteral(resourceName: "back_arrow_icon"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn1.addTarget(self, action: #selector(self.backButton), for: .touchDown)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setLeftBarButton(item1, animated: true)
        ////
    }
    
    @objc func backButton()  {
        dismiss(animated: true) {
            // self.UploadProfile()
        }
    }
    @IBAction func openGooglePicker(_ sender: Any) {
        openGooglePlace()
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
       // filter.type = .address
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func addAddress(){
//        var dict = ["user_id":currentUser!.info.inUserId!,"address1":lblAddress.text!,"address2":txtLandMark.text!,"lat":self.lat,"lng":lng,"name":lblName.text!] as [String : Any]
//        if isEdit{dict["address_id"] = addDetail?.id}
//        APIServices().AddAddress(params: dict,isEdit:self.isEdit, viewController: self, loader: true) {self.showSuccess(msg: self.isEdit ? "Address Updated":"Address Added")}
        
    }
}

extension AddAddressViewController : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
      let ulat = Double(place.coordinate.latitude)
    let   ulng = Double(place.coordinate.longitude)
    self.lat = String(ulat)
        self.lng = String(ulng)
//        for obj in place.addressComponents!{
//            if obj.types[0] == "route"{
//                SelectedLocality = obj.name
//
//            }
//        }
        self.lblAddress.text = place.formattedAddress!
        dismiss(animated: true, completion: nil)
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
