//
//  AppDelegate.swift
//  ballotPlanner
//
//  Created by Erika Giuse on 11/3/19.
//  Copyright © 2019 Erika Giuse. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  override init() {
    super.init()
    FirebaseApp.configure()
  }
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let mainStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let setupStoryboard = UIStoryboard(name: "UserSetUp", bundle:nil)
    var vc = UIViewController()
    print("user defaults", UserDefaults.standard.value(forKey: "party"), UserDefaults.standard.value(forKey: "location") )
    if UserDefaults.standard.value(forKey: "party") as! String? == nil || UserDefaults.standard.value(forKey: "location") as! Int? == nil{
      // if the app doesnt have users party and location, show welcome screen
      vc = setupStoryboard.instantiateViewController(withIdentifier: "Welcome")
    }
    else{
      //show main screen
      vc = mainStoryboard.instantiateInitialViewController()!
      
    }
    self.window?.rootViewController = vc
    self.window?.makeKeyAndVisible()
    
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
  }


}

