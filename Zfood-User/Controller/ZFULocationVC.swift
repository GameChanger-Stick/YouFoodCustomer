//
//  ZFULocationVC.swift
//  Zfood-User
//
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import GoogleMaps
var userLAT = 0.0
var userLNG = 0.0
var Selectedaddress = ""
var SelectedLocality = ""

class ZFULocationVC: CommonViewController, LocationUpdateProtocol {

    
    @IBOutlet weak var lblCurrentLocation: UILabel!
    var marker = GMSMarker()
    var didUpdate = false
    @IBOutlet weak var mapView: GMSMapView!
    var currentLocation : CLLocation!
    var locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var widthButton: NSLayoutConstraint!
    @IBOutlet weak var dimView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dimView.isHidden = true
        mapView.delegate = self
        marker.isDraggable = true
        self.lblCurrentLocation.text = ""
         getCurretLocation()
        let LocationMgr = UserLocationManager.SharedManager
            LocationMgr.delegate = self

        if let address = currentUser?.info.profileAddress,address != ""{
            if let lngA = currentUser?.info.lng,lngA != ""{
                if let latA = currentUser?.info.lat, latA != ""{
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                              appDelegate.setHomeRootViewController(forNoti: false)
                    GloAddress1 = address
                    GloLng = lngA
                    GloLat = latA
                    userLAT = Double(GloLat)!
                    userLNG = Double(GloLng)!
                }
            }
                  }else{
                     // self.showError(msg: "Select Location")
                  }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupStatusBarColor(isEnable: false)
    }
    func getCart(){
               self.isCart { (data) in
            if data != nil{
                let count = String(data?.data.count ?? 0)
                self.lblCount.text = count
            }else{
                self.lblCount.text = "0"
            }
        }

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        GloLng = "\(userLNG)"
               GloLat = "\(userLAT)"
    }
    @IBAction func chooseDifferentLocationButtonDidTap(_ sender: UIButton) {
        openGooglePlace()
    }
    
    @IBAction func handleMenuButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.drawerController.open(.left, animated: true) { (result) in
              }
    }
    
    @IBAction func handleNotification(_ sender: Any) {
        if isguest{
            self.view.makeToast("Please login")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.delegate = self
        vc.delegateChefDetail = self
        badgeCount = 0
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: vc.view.frame.size.width, height: 400)
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.permittedArrowDirections = .any
        vc.popoverPresentationController?.sourceView = btnNotification
        vc.popoverPresentationController?.sourceRect = btnNotification.bounds
        self.dimView.isHidden = false
                   self.present(vc, animated: true) {
                   }
    }
    
    @IBAction func handleCart(_ sender: Any) {
        if isguest{
            self.view.makeToast("Please login")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CART) as! ZFUCartVC
               let aObjNavi = UINavigationController(rootViewController: vc)
               aObjNavi.modalPresentationStyle = .fullScreen
               vc.navigationController?.navigationBar.isHidden = true
               
               self.present(aObjNavi, animated: true) {
               }
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
      //  filter.type = .address
        autocompleteController.autocompleteFilter = filter
        // Display the autocomplete view controller.
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
    @IBAction func findYourNearChefButtonDidTap(_ sender: UIButton) {
        if GloAddress1 != ""{
        UserDefaults.standard.set("SkipHOME", forKey: "HOME")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.setHomeRootViewController(forNoti: false)
        }else{
            self.showError(msg: "Select Location")
        }
    }
    
    // MARK: - Notifications
    @objc func locationUpdateNotification(notification: NSNotification) {
        let userinfo = notification.userInfo
        self.currentLocation = userinfo!["location"] as? CLLocation
        UserDefaults.standard.set(self.currentLocation.coordinate.latitude, forKey: "latitude")
        UserDefaults.standard.set(self.currentLocation.coordinate.longitude, forKey: "longitude")
        self.getAddressFromLatLon(pdblLatitude: self.currentLocation.coordinate.latitude, withLongitude: self.currentLocation.coordinate.longitude)
    }
    // MARK: - LocationUpdateProtocol
    func locationDidUpdateToLocation(location: CLLocation) {
        if userLNG == 0.0{
        currentLocation = location
            self.gotoToLocation(location: location.coordinate)
        }
    }
    func gotoToLocation(location: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                         longitude: location.longitude,
                                                         zoom:  35, bearing: 0, viewingAngle: 0)
                   if mapView.isHidden {
                     mapView.isHidden = false
                     mapView.camera = camera
                   } else {
                     mapView.animate(to: camera)
                   }
        self.mapView.clear()
                   let position = CLLocationCoordinate2D(latitude: location.latitude,longitude: location.longitude)
                 marker = GMSMarker(position: position)
                   marker.map = mapView
        if self.currentLocation == nil{
            return
        }
        //if self.currentLocation.coordinate.latitude != nil{
            UserDefaults.standard.set(location.latitude, forKey: "latitude")
                          UserDefaults.standard.set(location.longitude, forKey: "longitude")
            userLAT = location.latitude
                   userLNG = location.longitude
        if lblCurrentLocation.text == ""{  self.getAddressFromLatLon(pdblLatitude: location.latitude, withLongitude: location.longitude)
        }
      //  }
         
    }
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = pdblLatitude
        center.longitude = pdblLongitude
       
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                if placemarks == nil{
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    MyCommonFunctionalUtilities.saveUserCurrentLocation(placemark: pm)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        DispatchQueue.main.async {
                        }
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality!
                    }
                    
                    DispatchQueue.main.async {
                        if addressString != "" {
                            Selectedaddress = addressString
                            self.lblCurrentLocation.text = Selectedaddress
                            GloAddress1 = Selectedaddress
                            self.getCart()
                        }
                    }
                    
                }
        })
    }
    
    @IBAction func handleLocationBack(_ sender: Any) {
        self.view.endEditing(true)
    }
}

extension ZFULocationVC : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place ID: \(place.placeID)")
        print("Place attributions: \(place.attributions)")
        userLAT = Double(place.coordinate.latitude)
        userLNG = Double(place.coordinate.longitude)
        for obj in place.addressComponents!{
            if obj.types[0] == "route"{
                SelectedLocality = obj.name
            }
        }
        Selectedaddress = place.formattedAddress!
        GloAddress1 = Selectedaddress
        self.lblCurrentLocation.text = Selectedaddress
        self.getCart()
        GloAddress1 = Selectedaddress
        self.txtSearch.text = Selectedaddress
        self.gotoToLocation(location: place.coordinate)
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
extension ZFULocationVC : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.openGooglePlace()
        self.widthButton.constant = 0
        return false

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.widthButton.constant = 0
    }
}
extension ZFULocationVC : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
    }
}
extension ZFULocationVC : CLLocationManagerDelegate{
    func getCurretLocation()  {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()

            if locationManager.responds(to: #selector( CLLocationManager.requestAlwaysAuthorization)){
                locationManager.requestAlwaysAuthorization()
            } else {
                startUpdatingLocation()
            }
        }
    }
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            startUpdatingLocation()
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }

    
    
    //Updated location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        if !didUpdate{
        currentLocation = location
            didUpdate = true
            self.gotoToLocation(location: location.coordinate)
        }
    }
    
}
extension ZFULocationVC : UIPopoverPresentationControllerDelegate,DelegateDimVIEW{
func hideDimView() {
    
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.dimView.isHidden = true
        self.lblCount.isHidden = badgeCount == 0 ? true:false
        //self.CallNotificationAPI()
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

extension ZFULocationVC : GotoChefDetailDelegate{
//MARK:- GotoChefDetail

func gotoChefDetail(id: String) {
    self.dimView.isHidden = true
            let chefDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.CHEF_DETAILS)as! ZFUChefDetailsVC
            chefDetailsVC.chefId = id
    GlofromSearchList = false
                  chefDetailsVC.modalPresentationStyle = .overFullScreen
                  self.present(chefDetailsVC, animated: true, completion: nil)
        }
}
