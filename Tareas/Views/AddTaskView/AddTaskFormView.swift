//
//  AddTaskFormView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import SwiftUI

struct AddTaskFormView: View {
  @Binding var addTaskViewModel: AddTaskViewModel
  
  var body: some View {
    Form {
      Section(header: Text("Title").font(.largeTitle)) {
        VStack {
          TextField("Task Title",
                    text: $addTaskViewModel.taskTitle)
        }.padding()
      }
      
      Section(header: Text("Note").font(.largeTitle)) {
        VStack {
          TextField("Task Content ",
                    text: $addTaskViewModel.taskNote)
        }.padding()
      }
        
        Section(header: Text("Due Date").font(.largeTitle)) {
          VStack {
            DatePicker(selection: $addTaskViewModel.dueDate, label: { Text("Due Date") })
          }.padding()
        }
    }
  }
}


