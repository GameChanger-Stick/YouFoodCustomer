//
//  myFoodBegVC.swift
//  Zfood-User
//
//  Created by bhavya on 1/3/20.
//  Copyright © 2020 WemakeAppz. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class myFoodBegVC:  CommonViewController, LocationUpdateProtocol  {

    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var lblDeleverycharges: DesignableLabel!
    @IBOutlet weak var lblServiceFee: DesignableLabel!
    @IBOutlet weak var lblSubTotal: DesignableLabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblAdress1: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDliveryType: UILabel!
    
    @IBOutlet weak var address3: UITextField!
    @IBOutlet weak var deliveryChargeLogo: DesignableLabel!
    @IBOutlet weak var mapView: GMSMapView!
    var deliveryType = String()
    var presenterCart : CartPresenter?

var fromOrderScreen = Bool()
    var servicefee : String?
    var deliveryCharge : String?
    var marker = GMSMarker()
    var makingPurchase = false
       var paymentPresenter : stripPayment?
      var currentLocation : CLLocation!
    var cartTotal = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
         marker.isDraggable = true
            
             let LocationMgr = UserLocationManager.SharedManager
             LocationMgr.delegate = self
setUpData()
        self.presenterCart = CartPresenter.init(delegate: self, viewController: self)
               self.presenterCart?.getCart()
               paymentPresenter = stripPayment.init(delegate: self)
               paymentPresenter?.payment_Delegate = self
        currentLocation = CLLocation(latitude: userLAT, longitude: userLNG)
       self.gotoToLocation1(location: currentLocation.coordinate)
    }

    @IBAction func handleCheckOut(_ sender: Any) {
        if GloTotalAmount == "0" || GloTotalAmount == "0.0" || GloTotalAmount == "0.00"{
            self.paymentPresenter?.CreateOrder(loader: true, token: "")
        }else{
            
        
        gotoPAymentScreen()
        }}
    
    func gotoPAymentScreen(){
        let vc = storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.PaymentVC) as! PaymentVC
        let aObjNavi = UINavigationController(rootViewController: vc)
        aObjNavi.modalPresentationStyle = .fullScreen
        GloAddress1 = self.address3.text! + " " + self.lblAdress1.text!
            GloAddress2 = self.lblAddress2.text!
        vc.makingPurchase = true
        vc.navigationController?.navigationBar.isHidden = true
        self.present(aObjNavi, animated: true) {
        }
    }
    func setUpData(){
           self.lblSubTotal.text =  "$" + self.cartTotal
        self.lblServiceFee.text = "$" + GLoCreditFee
        if GloOrderType == "1"{
             self.lblDeleverycharges.text = "$" + self.deliveryCharge!
            self.deliveryChargeLogo.text = "Delivery charge"
        }else{
            self.lblDeleverycharges.text = ""
            self.deliveryChargeLogo.text = ""

        }
        let total = (GloOrderType == "1" ? (self.deliveryCharge?.FloatValue() ?? 0) : 0) + (GLoCreditFee.FloatValue() ) + ((self.cartTotal.FloatValue()))
        GloTotalAmount =  String(format: "%.2f", total)
        self.lblPrice.text = String(total)
        self.lblDate.text =  GloDeliveryTime
        self.lblDliveryType.text = self.deliveryType
        self.lblAdress1.text = GloAddress1
        self.lblAddress2.text = GloAddress2
       }
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
           }else{
            currentLocation = CLLocation(latitude: userLAT, longitude: userLNG)
                          self.gotoToLocation(location: location.coordinate)
        }
       }
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
           
           var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
           let ceo: CLGeocoder = CLGeocoder()
           center.latitude = pdblLatitude
           center.longitude = pdblLongitude
           userLAT = center.latitude
           userLNG = center.longitude
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
                    if pm.country != nil{
                        self.lblAddress2.text = pm.country
                    }
                       DispatchQueue.main.async {
                           if addressString != "" {
                               Selectedaddress = addressString
                            GloAddress1 = addressString
                               self.lblAdress1.text = Selectedaddress
                           }
                       }
                       
                   }
           })
       }
    
    func gotoToLocation1(location: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                         longitude: location.longitude,
                                                         zoom:  30)
                   if mapView.isHidden {
                     mapView.isHidden = false
                     mapView.camera = camera
                   } else {
                     mapView.animate(to: camera)
                   }
                   let position = CLLocationCoordinate2D(latitude: location.latitude,longitude: location.longitude)
                 marker = GMSMarker(position: position)
                   marker.map = mapView
            UserDefaults.standard.set(location.latitude, forKey: "latitude")
            UserDefaults.standard.set(location.longitude, forKey: "longitude")
        //userLAT = location.latitude
       // userLNG = location.longitude
              // self.getAddressFromLatLon(pdblLatitude: location.latitude, withLongitude: location.longitude)
    }
    
    func gotoToLocation(location: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                         longitude: location.longitude,
                                                         zoom:  30)
                   if mapView.isHidden {
                     mapView.isHidden = false
                     mapView.camera = camera
                   } else {
                     mapView.animate(to: camera)
                   }
                   let position = CLLocationCoordinate2D(latitude: location.latitude,longitude: location.longitude)
                 marker = GMSMarker(position: position)
                   marker.map = mapView
            UserDefaults.standard.set(location.latitude, forKey: "latitude")
            UserDefaults.standard.set(location.longitude, forKey: "longitude")
        userLAT = location.latitude
        userLNG = location.longitude
              //  self.getAddressFromLatLon(pdblLatitude: location.latitude, withLongitude: location.longitude)
        
    }
    @IBAction func chooseDifferentLocationButtonDidTap(_ sender: UIButton) {
         openGooglePlace()
     }
    //GMSPlaceFieldAll
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
    
    @IBAction func editAddress(_ sender: Any) {
    }
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
}
extension myFoodBegVC : GMSAutocompleteViewControllerDelegate {
    
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
                self.lblAddress2.text = obj.name
                       }
        }
        Selectedaddress = place.formattedAddress!
        GloAddress1 = Selectedaddress
        self.lblAdress1.text = Selectedaddress
        self.gotoToLocation(location: place.coordinate)
        dismiss(animated: true, completion: nil)
         self.presenterCart?.getCart()
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
extension myFoodBegVC : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
    }
}
//MARK:- CART DATA PROTOCOL
extension myFoodBegVC : CartProtocol{
    func success(data: Model_CART?) {
       // self.noitemView.isHidden = true
        if let datainfo = data{
            paymentPresenter!.cartDate = data

      
                            if datainfo.settingData != nil{
                                 GloDeliveryCharge = datainfo.settingData.deliveryCharge
                            }else{
                                 GloDeliveryCharge = "0"
                            }
            self.deliveryCharge! = GloDeliveryCharge
            self.setUpData()
        }
    }
    func failer(msg: String) {
      //  self.noitemView.isHidden = false
      //  self.view.bringSubviewToFront(noitemView)
        //self.errorNotice(msg)
    }
}
extension myFoodBegVC : PaymentDelegate{
    func success(msg: String) {
        self.showSuccessWithBtn(msg: msg , completion: {
                        self.gotoMyorder()
                     })
       // alertResponse(message: msg)
    }
    
    func fail(reason: String) {
        alertResponse(message: reason)
    }
    func gotoMyorder(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
             appDelegate.setOrderViewController()
     //        let login = self.storyboard?.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ORDERS) as! ZFUOrdersVC
     //        self.navigationController?.present(login, animated: true, completion: nil)
           }
    
}
