//
//  AddTaskView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import SwiftUI

struct AddTaskView: View {
  @State private var addTaskViewModel = AddTaskViewModel()
  @Binding var addTaskPresented: Bool
  
  var body: some View {
    NavigationView {
      VStack {
        AddTaskFormView(addTaskViewModel: $addTaskViewModel)
        AddTaskFormButtonView(addTaskViewModel: $addTaskViewModel, addTaskPresented: $addTaskPresented)
        Spacer()
        .navigationBarItems(trailing:
          Button(action: {
            self.addTaskPresented = false
        }) {
          Text("Done")
        })
      }
      .navigationBarTitle("Add Note")
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}
