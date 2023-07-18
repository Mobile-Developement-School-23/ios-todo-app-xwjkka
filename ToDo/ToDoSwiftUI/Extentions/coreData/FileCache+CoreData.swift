//
//  FileCache+CoreData.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 13.07.2023.
//

import Foundation
import CoreData

//struct TodoItemDataBase {
//    let id: String
//    let text: String
//    let importance: String
//    let deadline: Double?
//    let done: Bool
//    let created: Double
//    let changed: Double?
//}

class FileCacheCoreData {
    
    private lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "DataModel")
            container.loadPersistentStores { storeDescription, error in
                if let error = error {
                    print(error)
                }
            }
            return container
        }()
        
        func saveContext() {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("\(error)")
                }
            }
        }
        
    func saveToCoreData(list: [TodoItem]) {
            let fetchRequest: NSFetchRequest <Entity> = Entity.fetchRequest()
            
            do {
                let objects = try persistentContainer.viewContext.fetch(fetchRequest)
                for object in objects {
                    persistentContainer.viewContext.delete(object)
                    saveContext()
                }
                
                for item in list {
                    insertInCoreData(item: item)
                }
                
            } catch {
                print("\(error)")
            }
        }
    
        func insertInCoreData(item: TodoItem) {
            let newItem = Entity(context: persistentContainer.viewContext)
            newItem.id = item.id
            newItem.text = item.text
            newItem.importance = item.importance.rawValue
            newItem.deadline = item.deadline
            newItem.changed = item.changed
            newItem.created = item.created
            newItem.done = item.done

            saveContext()
        }
    
        func updateInCoreData(item: TodoItem) {
            let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)
            fetchRequest.fetchLimit = 1

            do {
                let itemToUpdate = try persistentContainer.viewContext.fetch(fetchRequest)

                if let toUpdate = itemToUpdate.first {
                    toUpdate.text = item.text
                    toUpdate.importance = item.importance.rawValue
                    toUpdate.deadline = item.deadline
                    toUpdate.changed = item.changed
                    toUpdate.created = item.created
                    toUpdate.done = item.done
                }
                saveContext()

            } catch {
                print("\(error)")
            }
        }

        func deleteFromCoreData(itemID: String) {
            let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id = %@", itemID)
            fetchRequest.fetchLimit = 1

            do {
                let itemToDelete = try persistentContainer.viewContext.fetch(fetchRequest)

                if let toDelete = itemToDelete.first {
                    persistentContainer.viewContext.delete(toDelete)
                    saveContext()
                }
            } catch {
                print(error)
            }
        }
    
    func parseFromCoreData(item: Entity) -> TodoItem {
        let importance = Importance(rawValue: item.importance ?? "regular") ?? Importance.regular
        
        return TodoItem(id: item.id!, text: item.text!, importance: importance, deadline: item.deadline, done: item.done, created: item.created!, changed: item.changed)
    }
    
    func loadFromCoreData() -> [TodoItem] {
        var loadedList = [TodoItem]()
        do {
            let fetchItems = try persistentContainer.viewContext.fetch(Entity.fetchRequest())

            for item in fetchItems {
                loadedList.append(parseFromCoreData(item: item))
            }

        } catch {
            print("\(error)")
        }
        return loadedList
    }
}
