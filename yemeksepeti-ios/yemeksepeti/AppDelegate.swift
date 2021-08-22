//
//  AppDelegate.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import UIKit
import Firebase
import CoreData
import IQKeyboardManagerSwift
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        let info = LocalDBNetwork.shared.isUserExist()
        if let userInfo = info {
            UserManager.shared.loadUserId(Int(userInfo.id))
        }
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbar = TabBarRouter.createModule()
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        return true
    }

    //MARK: - Core Data Saving Support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
