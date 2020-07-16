//
//  TaskDetailView.swift
//  Tareas
//
//  Created by Anton Zuev on 16/07/2020.
//

import SwiftUI

struct TaskDetailView: View {
  @State var taskModel: TaskModel
  
  var body: some View {
        Form {
          Section(header: Text("Title").font(.largeTitle)) {
            VStack {
              Text(taskModel.title)
            }.padding()
          }
          
          Section(header: Text("Note").font(.largeTitle)) {
            VStack {
              Text(taskModel.note)
            }.padding()
          }
            
            Section(header: Text("Due Date").font(.largeTitle)) {
              VStack {
                Text(taskModel.dueDate)
              }.padding()
            }
        }
      .navigationBarTitle("Details")
  }
}
