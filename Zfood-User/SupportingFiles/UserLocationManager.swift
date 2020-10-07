//
//  UserLocationManager.swift
//  Zfood-User
//
//  Created by apple on 31/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}
/// Notification on update of location. UserInfo contains CLLocation for key "location"
let kLocationDidChangeNotification = "LocationDidChangeNotification"
let changeScreenNotification = "ChangeScreenNotification"
class UserLocationManager: NSObject, CLLocationManagerDelegate {
    static let SharedManager = UserLocationManager()
    private var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var delegate : LocationUpdateProtocol!
    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Error: " + (error?.localizedDescription)!)
                return
            }
            if ((placemarks?.count)! > 0) {
                let pm = placemarks![0]
                self.currentLocation = pm.location!
                let userInfo : NSDictionary = ["location" : self.currentLocation!]
                DispatchQueue.main.async {
                    self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
                    self.locationManager.stopUpdatingLocation()
                }
            }
            
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // MARK: - Check for location permissions
    func areLocationPermissionsAvailable() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            
            let alertController = UIAlertController(title: "Location Access Disabled", message: "MiChef Will use your location.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url , options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                        
                    }
                }
            }
            alertController.addAction(openAction)
            
            (UIApplication.shared.delegate as! AppDelegate).window!.rootViewController?.present(alertController, animated: true, completion: nil)
            return false
        }
    }
    
}
