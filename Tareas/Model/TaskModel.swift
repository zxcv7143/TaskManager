//
//  TaskModel.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import Foundation

class TaskModel: Identifiable, ObservableObject, Hashable, Codable {
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        if lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.note == rhs.note &&
            lhs.dueDate == rhs.dueDate &&
            lhs.completed == rhs.completed   {
            return true
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    
    
  let id: UUID
  var title: String
  var note: String
  var dueDate: String
  var completed: Bool
  
  init(task: Task) {
    guard
      let noteId = task.id,
      let title = task.title,
      let note = task.note,
      let dueDate = task.dueDate
      else {
        fatalError("Invalid note")
    }
    
    self.id = noteId
    self.title = title
    self.note = note
    self.completed = task.completed
    self.dueDate = DateUtils.displayDate(for: dueDate)
  }
  
    init(id: UUID, title: String, note: String, completed: Bool) {
        self.id = id
        self.title = title
        self.note = note
        self.completed = completed
        
        let date = Date()
        self.dueDate = DateUtils.displayDate(for: date)
  }
}
