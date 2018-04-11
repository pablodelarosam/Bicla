//
//  AppDelegate.swift
//  Bicla
//
//  Created by Pablo de la Rosa Michicol on 1/21/18.
//  Copyright © 2018 CraftCode. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import UserNotifications
import EstimoteProximitySDK


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
  
    var proximityObserver: EPXProximityObserver!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            print("notifications permission granted = \(granted), error = \(error?.localizedDescription ?? "(none)")")
        }
        
        
       
      
        
        let estimoteCloudCredentials = EPXCloudCredentials(appID: "testapp-41g", appToken: "296c4d31973bcff55d704899f0d4d2a5")
        
        proximityObserver = EPXProximityObserver(credentials: estimoteCloudCredentials, errorBlock: { error in
            print("EPXProximityObserver error: \(error)")
        })
        
        let zone = EPXProximityZone(range: EPXProximityRange.custom(desiredMeanTriggerDistance: 3.0)!,
                                    attachmentKey: "testbeacon-bls", attachmentValue: "example-proximity-zone")
        zone.onEnterAction = { attachment in
            let content = UNMutableNotificationContent()
            content.title = "Rodada Cholula"
            content.body = "Te invitamos a está increíble rodada organizada por Bicla!"
            let imageData = NSData(contentsOf:NSURL(string: "https://s3.amazonaws.com/images-bicla/untitled+(1).jpg")! as URL)
            
            let attachment = UNNotificationAttachment.create(imageFileIdentifier: "splash.png", data: imageData!, options: nil)
            
            
            content.attachments = [attachment!]
            content.sound = UNNotificationSound.default()
            let request = UNNotificationRequest(identifier: "enter", content: content, trigger: nil)
            notificationCenter.add(request, withCompletionHandler: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let next = storyboard.instantiateViewController(withIdentifier: "EstimoteViewController") as! EstimoteViewController
            
            //next.beacon = beacon
            
            self.window?.rootViewController = next
        }
        zone.onExitAction = { attachment in
            let content = UNMutableNotificationContent()
            content.title = "Rodada Cholula"
            content.body = "Te invitamos a está increíble rodada organizada por Bicla!"
            let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            let tempFileURL = tempDirURL.appendingPathComponent("splash.png")
      
            let imageData = NSData(contentsOf:NSURL(string:  "https://s3.amazonaws.com/images-bicla/untitled+(1).jpg")! as URL)
      
            let attachment = UNNotificationAttachment.create(imageFileIdentifier: "splash.png", data: imageData!, options: nil)
 
            
            content.attachments = [attachment!]
            content.sound = UNNotificationSound.default()
            let request = UNNotificationRequest(identifier: "exit", content: content, trigger: nil)
            notificationCenter.add(request, withCompletionHandler: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let next = storyboard.instantiateViewController(withIdentifier: "EstimoteViewController") as! EstimoteViewController
            
            //next.beacon = beacon
            
            self.window?.rootViewController = next
        }
        
        proximityObserver.startObserving([zone])
        
    
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }
    
func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
    let notification = UILocalNotification()
    notification.alertBody =
        "Your gate closes in 47 minutes. " +
        "Current security wait time is 15 minutes, " +
        "and it's a 5 minute walk from security to the gate. " +
        "Looks like you've got plenty of time!"
    UIApplication.shared.presentLocalNotificationNow(notification)
}
    
    func openAddController(){
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String , annotation: options[UIApplicationOpenURLOptionsKey.annotation] )
        
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Needs to be implemented to receive notifications both in foreground and background
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.sound])
    }
}

extension UNNotificationAttachment {
    static func create(imageFileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let fileURLPath = NSURL(fileURLWithPath: NSTemporaryDirectory())
        let tmpSubFolderURL = fileURLPath.appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = tmpSubFolderURL?.appendingPathComponent(imageFileIdentifier)
            try data.write(to: fileURL!, options: [])
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL!, options: options)
            return imageAttachment
            
        } catch
                let error { print("error \(error)")
            
        }
        return nil }
    
}



