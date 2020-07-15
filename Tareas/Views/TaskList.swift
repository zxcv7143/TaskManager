//
//  ContentView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    @State var addModalIsPresented = false
    
    var body: some View {
        VStack {
            NavigationView {
              List {
                ForEach(self.taskListViewModel.tasks) { taskModel in
                    TaskCellView(taskModel: taskModel) {isChecked in
                        self.taskListViewModel.updateTaskCompleted(taskId: taskModel.id, isCompleted: isChecked)
                        self.taskListViewModel.fetchAllTasks()
                    }
                }.onDelete { indexSet in
                  self.taskListViewModel.deleteItem(for: indexSet)
                }
              }.onAppear {
                self.taskListViewModel.fetchAllTasks()
              }
              .navigationBarTitle("Tasks")
              .navigationBarItems(leading: Button(action: {
                self.addModalIsPresented = true
              }) {
                Image(systemName: "plus.circle.fill")
                  .font(.largeTitle)
              })}
            .navigationViewStyle(StackNavigationViewStyle())
            
            Text("").sheet(isPresented: $addModalIsPresented, onDismiss: {
              print("ONDISMISS")
              self.taskListViewModel.fetchAllTasks()
            }, content: {
              AddTaskView(addTaskPresented: self.$addModalIsPresented)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
