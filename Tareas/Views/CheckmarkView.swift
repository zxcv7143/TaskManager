//
//  CheckmarkView.swift
//  Tareas
//
//  Created by Anton Zuev on 14/07/2020.
//

import SwiftUI

struct CheckmarkView: View {
    @Binding var isChecked: Bool
    var onCheckedChanged: (_ isChecked: Bool)->()?
    
    func toggle(){
        isChecked = !isChecked
        self.onCheckedChanged(isChecked)
    }
    
    var body: some View {
        Button(action: toggle)
            {
            Image(systemName: isChecked ? "checkmark.square": "square").resizable().frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red)
        }.buttonStyle(BorderlessButtonStyle())
    }
    
}

