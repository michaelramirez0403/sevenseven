//
//  CoreDataManager.swift
//  Deliveries
//
//  Created by Macky Ramirez on 5/18/20.
//  Copyright © 2020 Macky Ramirez. All rights reserved.
//
import Foundation
import CoreData
class CoreDataManager {
    static let sharedManager = CoreDataManager()
//    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "SwiftPass")
      container.loadPersistentStores(completionHandler: { (_, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    // MARK: - Set up a Core Data in-memory store to avoid persistent changes during testing.
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "SwiftPass")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
    func saveContext () {
      let context = CoreDataManager.sharedManager.persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    func insertUserDetails(_ user: UsersDetails) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity         = NSEntityDescription.entity(forEntityName: "Users",
                                                        in: managedContext)!
        let item           = NSManagedObject(entity: entity,
                                             insertInto: managedContext)
        item.setValue(user.email, forKey: "email")
        item.setValue(user.password, forKey: "password")
        do {
            try managedContext.save()
            print("Saved items in core data")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getUserDetails(_ identifier: String) -> Users? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", identifier)
        do {
            let items = try managedContext.fetch(fetchRequest)
            return items.first 
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    func checkIfItemExist(_ email: String, _ password: String) -> Bool {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "email == %@" ,email)
        fetchRequest.predicate = NSPredicate(format: "password == %@", password)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count >= 1 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
}
