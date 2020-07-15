//
//  AddTaskButtonView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import SwiftUI

struct AddTaskFormButtonView: View {
  @Binding var addTaskViewModel: AddTaskViewModel
  @Binding var addTaskPresented: Bool
  
  var body: some View {
    HStack {
      Button("Add Task") {
        self.addTaskViewModel.createTask()
        self.addTaskPresented = false
      }.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
        .foregroundColor(Color.white)
      .background(Color.blue)
        .cornerRadius(10)
    }
  }
}
