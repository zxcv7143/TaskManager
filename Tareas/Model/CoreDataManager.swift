//
//  CoreDataManager.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import CoreData
import UIKit

class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: "Tasks")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchAllTask() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let context = persistentContainer.viewContext
        guard let results = try? context.fetch(fetchRequest) else {
            return []
        }
        
        return results
    }
    
    func fetchAllTodayUnCompletedTasks() -> [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
//        fetchRequest.predicate = NSPredicate(format: "completed == %@",NSNumber(value: false))
        let context = persistentContainer.viewContext
        guard let results = try? context.fetch(fetchRequest) else {
            return []
        }
        
        return results
    }
    
    func createTask(for title: String, note: String, dueDate: Date) {
        let managedObjectContext = persistentContainer.viewContext
        let task = Task(context: managedObjectContext)
        task.title = title
        task.note = note
        task.dueDate = dueDate
        task.id = UUID()
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func fetchTask(for id: UUID) -> Task? {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = predicate
        let context = persistentContainer.viewContext
        
        guard let results = try? context.fetch(fetchRequest) else {
            return nil
        }
        
        return results.first
    }
    
    func delete(for taskId: UUID) {
        guard let task = fetchTask(for: taskId) else {
            return
        }
        
        let context = persistentContainer.viewContext
        
        do {
            context.delete(task)
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
}
