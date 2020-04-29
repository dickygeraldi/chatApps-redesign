//
//  HomeCoreData.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit
import CoreData

class HomeDataCore {
    
    func storeDataToTopic(topic: Topic) {
        let image = topic.image.pngData()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let topicEntity = NSEntityDescription.entity(forEntityName: "DataTopics", in: context)!
        
        let listTopic = NSManagedObject(entity: topicEntity, insertInto: context)
        
        listTopic.setValue(topic.category, forKey: "category")
        listTopic.setValue(topic.headline, forKey: "headline")
        listTopic.setValue(topic.idData, forKey: "idTopic")
        listTopic.setValue(image, forKey: "image")
        listTopic.setValue(topic.sendingTime, forKey: "time")
        listTopic.setValue(topic.topicLasMessage, forKey: "topicLastMessage")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Gagal save context \(error), \(error.userInfo)")
        }
    }
    
    func deleteData(entity: String, uniqueId: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "idTopic = %@", uniqueId)
        
        do{
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
    }
    
    func updateDate(entity: String, uniqueId: String, taskName: String, duration: Int, start: String) -> String {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return "" }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id = %@", uniqueId)
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
        
            dataToUpdate.setValue(taskName, forKey: "taskName")
            dataToUpdate.setValue(duration, forKey: "duration")
            dataToUpdate.setValue(start, forKey: "start")
            
            try managedContext.save()
        }catch let err{
            print(err)
        }
        
        return "00"
    }
    
    func updateTopic(message: String, Sending: String, idTopic: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchrequest :NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "DataTopics")
        fetchrequest.predicate = NSPredicate(format: "idTopic = %@", idTopic)
        
        do {
            
            let fetch = try context.fetch(fetchrequest)
            let listTopic = fetch[0] as! NSManagedObject
            
            listTopic.setValue(Sending, forKey: "time")
            listTopic.setValue(message, forKey: "topicLastMessage")
            
            try context.save()
            
        } catch let err {
            print(err)
        }
    }

    func retrieveTopic() -> [Topic] {
        
        var temp: [Topic] = []
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return temp}
        let context = appDel.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DataTopics")
        
        do {
            let result = try context.fetch(fetch)
            for data in result as! [NSManagedObject] {
                var dataImage: UIImage
        
                dataImage = UIImage(data: data.value(forKey: "image") as! Data) ?? UIImage(named: "addImages")!
                
                temp.append(Topic(image: dataImage, headline: data.value(forKey: "headline") as! String, topicLastMessage: data.value(forKey: "topicLastMessage") as! String, sendingTime: data.value(forKey: "time") as! String, category: data.value(forKey: "category") as! String, idData: data.value(forKey: "idTopic") as! String))
            }
        } catch {
            print("Failed")
        }
        
        print(temp)
        
        return temp
    }
 
    func checkingMessage(topicId: String) -> [ChatModels] {
        var temp: [ChatModels] = [
            ChatModels(message: "Anda telah membuat topik", isIncoming: 1, sender: "Admin", time: "")
        ]
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return temp}
        let context = appDel.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChatPerTopics")
        
        do {
            let result = try context.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if data.value(forKey: "idTopic") as! String == topicId {
                    temp.append(ChatModels(message: data.value(forKey: "message") as! String, isIncoming: (data.value(forKey: "isIncoming") as! Int), sender: data.value(forKey: "whoSending") as! String, time: data.value(forKey: "time") as! String))
                }
            }
        } catch {
            print("Failed")
        }
        
        return temp
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
