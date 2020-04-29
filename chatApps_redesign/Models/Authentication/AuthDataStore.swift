//
//  AuthDataStore.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit
import CoreData

class AuthDataCore {
    
    // function for update rows in core data by id
    func updateDate(entity: String, uniqueId: String, userAuth: UserAuth) -> String {
        var message: String = ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return "" }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "username = %@", uniqueId)
        
        do {
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
        
            dataToUpdate.setValue(userAuth.phoneNumber, forKey: "phoneNumber")
            dataToUpdate.setValue(userAuth.token, forKey: "token")
            dataToUpdate.setValue(userAuth.username, forKey: "username")
            
            message = "00"
            try managedContext.save()
            
        } catch let err {
            message = "05"
            print(err)
        }
        
        return message
    }
    
    // function for store data by entity and Data
    func storeData(entity: String, userAuth: UserAuth) -> String {
        
        var message: String = ""
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return "" }
        
        let context = appDelegate.persistentContainer.viewContext
        let dataOfEntity = NSEntityDescription.entity(forEntityName: entity, in: context)!
        let listOfEntity = NSManagedObject(entity: dataOfEntity, insertInto: context)
        
        listOfEntity.setValue(userAuth.phoneNumber, forKey: "phoneNumber")
        listOfEntity.setValue(userAuth.token, forKey: "token")
        listOfEntity.setValue(userAuth.username, forKey: "username")
        
        do {
           try context.save()
           message = "00"
            
        } catch let error as NSError {
            
            print("Gagal save context \(error), \(error.userInfo)")
            message = "05"
        }
        
        return message
    }
    
    // Function for retrieve data userAuth
    func retrieveData(entity: String) -> UserAuth {
        
        var phoneNumber: String = ""
        var token: String = ""
        var username: String = ""
        
        var userAuth: UserAuth = UserAuth.init(phoneNumber: phoneNumber, token: token, username: username)
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return userAuth }
        let context = appDel.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

        do {
            let result = try context.fetch(fetch)
            for data in result as! [NSManagedObject] {
                phoneNumber = data.value(forKey: "phoneNumber") as! String
                token = data.value(forKey: "token") as! String
                username = data.value(forKey: "username") as! String
            }
            
        } catch {
            print("Failed")
        }
        
        userAuth = UserAuth.init(phoneNumber: phoneNumber, token: token, username: username)
        
        return userAuth
    }
    
    func storeDataMessage(messageData: ChatModels, topicId: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let context = appDelegate.persistentContainer.viewContext
        
        let messageEntity = NSEntityDescription.entity(forEntityName: "ChatPerTopics", in: context)!
        
        let listMessage = NSManagedObject(entity: messageEntity, insertInto: context)
        
        listMessage.setValue(messageData.isIncoming, forKey: "isIncoming")
        listMessage.setValue(messageData.message, forKey: "message")
        listMessage.setValue(messageData.sender, forKey: "whoSending")
        listMessage.setValue(messageData.time, forKey: "time")
        listMessage.setValue(topicId, forKey: "idTopic")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Gagal save context \(error), \(error.userInfo)")
        }
    }
}
