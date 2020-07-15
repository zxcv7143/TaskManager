//
//  AddTaskViewModel.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import Foundation
import UIKit

class AddTaskViewModel: ObservableObject {
  @Published var taskTitle = ""
  @Published var taskNote = ""
  @Published var dueDate = Date()
  
  func createTask() {
    CoreDataManager.sharedInstance.createTask(for: taskTitle, note: taskNote, dueDate: dueDate)
    clearValues()
  }
  
  private func clearValues() {
    taskTitle = ""
    taskTitle = ""
  }
}
