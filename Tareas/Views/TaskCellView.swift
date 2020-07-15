//
//  TaskCellView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import Foundation

import SwiftUI

struct TaskCellView: View {
  @State var taskModel: TaskModel
  var onCheckMarkValueChanged: (_ isChecked: Bool) -> ()
  
  var body: some View {
    VStack {
      HStack {
        CheckmarkView(isChecked: $taskModel.completed, onCheckedChanged: { isChecked in
            self.onCheckMarkValueChanged(isChecked)
        })
        Text(taskModel.title)
          .font(.system(size: 25))
          .padding()
        Spacer()
        Text(taskModel.dueDate)
          .font(.system(size: 20))
          .padding()
      }
      HStack {
        Text(taskModel.note)
          .padding()
          .font(.system(size: 20))
          .foregroundColor(.gray)
        Spacer()
      }
    }
  }
}

struct NoteCell_Previews: PreviewProvider {
  static var previews: some View {
    TaskCellView(taskModel: TaskModel(id: UUID(), title: "Test Title", note: "Test Content", completed: false), onCheckMarkValueChanged: {_ in })
  }
}
