//
//  TaskListViewModel.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import Foundation

class TaskListViewModel: ObservableObject {
  @Published var tasks: [TaskModel] = []
  
  @objc func handleNoteCreated() {
    fetchAllTasks()
  }
  
  func fetchAllTasks() {
    let tasks = CoreDataManager.sharedInstance.fetchAllTask().map(TaskModel.init)
    self.tasks = tasks
  }
    
  func updateTaskCompleted(taskId: UUID, isCompleted: Bool) {
    print("Task completed:\(isCompleted)")
    let task = CoreDataManager.sharedInstance.fetchTask(for: taskId)
    task?.completed = isCompleted
    CoreDataManager.sharedInstance.save()
  }
    
  func deleteItem(for indexSet: IndexSet) {
    guard let itemIndex = indexSet.first else {
      return
    }
    
    let item = tasks[itemIndex]
    CoreDataManager.sharedInstance.delete(for: item.id)
    tasks.remove(at: itemIndex)
  }
}

