//
//  LocalDbNetwork.swift
//  yemeksepeti
//
//  Created by semra on 21.08.2021.
//

import CoreData
import Foundation
import UIKit

final class LocalDBNetwork {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //This is weak
    //Because of singleton
    weak var delegate: LocalDBDelegate?
    private var userArray = [UserInfo]()
    static let shared = LocalDBNetwork()
    
    func saveUser() {
        do {
            try context.save()
            self.loadUser()
        } catch {
            print("Error, saving context: \(error.localizedDescription)")
        }
    }
    
    func loadUser() {
        userArray.removeAll()
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        do {
            userArray = try context.fetch(request)
            
            self.delegate?.didUpdateUser(self, userInfo:  userArray[0])
        }catch {
            print("Error, loading from context: \(error.localizedDescription)")
        }
    }
    
     func isUserExist() -> UserInfo? {
        let request: NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            let count = objects.count
            if(count != 0) {
                return objects[0]
            }
        } catch {
            print("Error about deleting: \(error.localizedDescription)")
            return nil
        }
        return nil
    }
    
    private func clearAllCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer
        let entities = context.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }
    
    private func clearDeepObjectEntity(_ entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}

protocol LocalDBDelegate: AnyObject {
    func didUpdateUser(_ localDBNetwork: LocalDBNetwork, userInfo: UserInfo)
}
