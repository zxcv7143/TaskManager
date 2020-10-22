//
//  CoreDataManager.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import CoreData
import UIKit
import Combine
import WidgetKit


class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    private var cancellables = [AnyCancellable]()
    
    private init() {
        let notificationCancellable = NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: self.persistentContainer.viewContext).sink { _ in
            WidgetCenter.shared.reloadAllTimelines()
        }
        cancellables.append(notificationCancellable)
    }
    
    private enum AppGroup: String {
      case tasks = "group.com.antonzuev.tasks.Tareas"

      public var containerURL: URL {
        switch self {
        case .tasks:
          return FileManager.default.containerURL(
          forSecurityApplicationGroupIdentifier: self.rawValue)!
        }
      }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let storeURL = AppGroup.tasks.containerURL.appendingPathComponent("Tasks.sqlite")
        let description = NSPersistentStoreDescription(url: storeURL)
        let container = NSPersistentContainer(name: "Tasks")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
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
        fetchRequest.predicate = NSPredicate(format: "dueDate < %@ AND completed == NO", DateUtils.tomorrow() as CVarArg)
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
