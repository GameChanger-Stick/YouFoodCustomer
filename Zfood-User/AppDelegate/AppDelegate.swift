//
//  AppDelegate.swift
//  Zfood-User
//  Created by apple on 06/05/19.
//  Copyright © 2019 WemakeAppz. All rights reserved.

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import GooglePlaces
import GoogleMaps
import UserNotifications

var currentUser : ModelUser?
var badgeCount = 0

var tokenStrip = ""
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    var drawerController:MMDrawerController!
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var centerContainer:MMDrawerController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SetNavigation()
        
       
        FIRApp.configure()
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print(uuid)
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
         IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        if UserDefaults.standard.object(forKey: "TUTORIAL") == nil {
        }else if UserDefaults.standard.object(forKey: "OTP") == nil {
        }else {}
        
        GMSPlacesClient.provideAPIKey("AIzaSyCa0GK9s9H3uok8vM7HVk8dLpuDt3dYN6E")
        GMSServices.provideAPIKey("AIzaSyCa0GK9s9H3uok8vM7HVk8dLpuDt3dYN6E")
loginUserDetail()
        registerForPushNotifications()
        firstTimeuser()
        return true
    }
    func loginUserDetail(){
        if UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) != nil{
            currentUser = ModelUser.init(fromDictionary: UserDefaults.standard.value(forKey: Constants.userDefaults.userDetail) as! [String:Any])
        }
    }
    func firstTimeuser(){
        if  UserDefaults.standard.value(forKey: Constants.userDefaults.firstTime) == nil{
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                                                     let initialViewControlleripad = mainStoryboardIpad.instantiateViewController(withIdentifier: "walkthrughVC") as! walkthrughVC
                                                                         let nav = UINavigationController(rootViewController: initialViewControlleripad)
                                                             nav.navigationBar.isHidden = true
                                                             nav.modalPresentationStyle = .fullScreen
                   UserDefaults.standard.set(true, forKey: Constants.userDefaults.firstTime)
                                                             
            window?.rootViewController = initialViewControlleripad
            window?.makeKeyAndVisible()
        }
    }
    func setHomeRootViewController(forNoti:Bool) {
        let menuVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.MENU) as! ZFUMenuVC
        let homeVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.HOME) as! ZFUHomeVC
        homeVC.forNotification = forNoti
        let leftNav = UINavigationController(rootViewController: menuVC)
        let homeNav = UINavigationController(rootViewController: homeVC)
        drawerController = MMDrawerController(center: homeNav, leftDrawerViewController: leftNav)
        drawerController.maximumLeftDrawerWidth = UIScreen.main.bounds.maxX * 0.70
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        drawerController.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) -> Void in
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.left){
                sideDrawerViewController = drawerController!.leftDrawerViewController;
            }
            sideDrawerViewController?.view.alpha = percentVisible
        }
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
    }
    
    func setLocationViewController(forNoti:Bool) {
        let menuVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.MENU) as! ZFUMenuVC
        let homeVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.LOCATION) as! ZFULocationVC
       // homeVC.forNotification = forNoti
        let leftNav = UINavigationController(rootViewController: menuVC)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.navigationBar.isHidden = true
        drawerController = MMDrawerController(center: homeNav, leftDrawerViewController: leftNav)
        drawerController.maximumLeftDrawerWidth = UIScreen.main.bounds.maxX * 0.70
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        drawerController.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) -> Void in
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.left){
                sideDrawerViewController = drawerController!.leftDrawerViewController;
            }
            sideDrawerViewController?.view.alpha = percentVisible
        }
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
    }
    

    
    func setOrderViewController() {
        
        let menuVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.MENU) as! ZFUMenuVC
        let homeVC = storyboard.instantiateViewController(withIdentifier: UIVIEWCONTROLLER_IDENTIFIRE.ORDERS) as! ZFUOrdersVC
        let leftNav = UINavigationController(rootViewController: menuVC)
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        drawerController = MMDrawerController(center: homeNav, leftDrawerViewController: leftNav)
        drawerController.maximumLeftDrawerWidth = UIScreen.main.bounds.maxX * 0.70
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        drawerController.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) -> Void in
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.left){
                sideDrawerViewController = drawerController!.leftDrawerViewController;
            }
            sideDrawerViewController?.view.alpha = percentVisible
        }
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
    }
    
    func setLandingRootViewController() {

    }
    
    func setTutorialRootViewController() {

    }
    func SetNavigation()  {
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .default
    }
    func registerForPushNotifications() {
          UNUserNotificationCenter.current().delegate = self
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
              (granted, error) in
              print("Permission granted: \(granted)")
              // 1. Check if permission granted
              guard granted else { return }
              // 2. Attempt registration for remote notifications on the main thread
              DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
              }
          }
      }
      func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          // 1. Convert device token to string
          let tokenParts = deviceToken.map { data -> String in
              return String(format: "%02.2hhx", data)
          }
          let token = tokenParts.joined()
          // 2. Print device token to use for PNs payloads
          print("Device Token: \(token)")
  MydeviceToken = token
      }
      
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
          // 1. Print out error if PNs registration not successful
          print("Failed to register for remote notifications with error: \(error)")
      }
      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        badgeCount += 1
        NotificationCenter.default.post(name: .badgeNoti, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationCenter.reloadOrderList), object: nil)
        if let info = userInfo as? [String : Any]{
            if  let alert = (info["aps"] as! [String : Any ])["alert"] as? [String : Any]{
                if let type = alert["type"] as? String{
                    if type == "1"{
                        self.setOrderViewController()
                    }
                }
            }}
        
      }
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          completionHandler( [.alert, .badge, .sound])
          print(notification)
        
          
      }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
        if let info = userInfo as? [String : Any]{
            if  let alert = (info["aps"] as! [String : Any ])["alert"] as? [String : Any]{
                if let type = alert["type"] as? String{
                    if type != "1"{
                        self.setHomeRootViewController(forNoti: true)
                    }else {
                        if let info = userInfo as? [String : Any]{
                               if  let alert = (info["aps"] as! [String : Any ])["alert"] as? [String : Any]{
                                   if let type = alert["type"] as? String{
                                       if type == "1"{
                                           self.setOrderViewController()
                                       }
                                   }
                        }}}
                }
            }}


    }
    func applicationWillResignActive(_ application: UIApplication) {
     
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Zfood_User")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
