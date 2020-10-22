//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by Anton Zuev on 15/07/2020.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    public func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), tasks: [TaskModel(id: UUID(), title: "task", note: "SimpleNote", completed: false)])
        completion(entry)
    }

    public func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        let tasksUncompleted = CoreDataManager.sharedInstance.fetchAllTodayUnCompletedTasks().map(TaskModel.init)
        // Generate a timeline consisting of entries of tasks that should will be completed today.
        for i in 0 ..< tasksUncompleted.count {
            let entryDate = DateUtils.getDateFromString(for: tasksUncompleted[i].dueDate)?.addingTimeInterval(-6200)
            let entry = SimpleEntry(date: entryDate ?? Date(), tasks: tasksUncompleted)
            entries.append(entry)
        }
        if entries.isEmpty {
            entries.append(SimpleEntry(date: Date(), tasks: []))
        }
        let timeline = Timeline(entries: entries, policy:.atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), tasks: [TaskModel(id: UUID(), title: "Task", note: "Note", completed: false)])
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let tasks: [TaskModel]
//    public let configuration: ConfigurationIntent
}


struct TaskView: View {
    let task: TaskModel
    
    var body: some View {
        HStack {
            Image(systemName: "square").foregroundColor(.red)
            Text(task.title )
            .font(.system(size: 15))
        }
        Text(task.dueDate)
            .font(.system(size: 10))
        Text(task.note)
            .font(.system(size: 10))
    }
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            if entry.tasks.count > 0 {
                VStack(alignment: .leading) {
                    ForEach(entry.tasks, id: \.self) { task in
                        TaskView(task: task)
                   }
                }.padding(5)
            } else {
                Text("No tasks")
            }
        default:
            if entry.tasks.count > 0 {
                VStack(alignment: .leading) {
                    ForEach(entry.tasks, id: \.self) { task in
                        TaskView(task: task)
                   }
                }.padding(5)
            } else {
                Text("No tasks")
            }
        }
        
    }
}

@main
struct TaskWidget: Widget {
    private let kind: String = "TaskWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}

struct TaskWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TaskWidgetEntryView(entry: SimpleEntry(date: Date(), tasks: [TaskModel(id: UUID(), title: "Task", note: "Note", completed: false), TaskModel(id: UUID(), title: "Task very important", note: "Note", completed: false)]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            TaskWidgetEntryView(entry: SimpleEntry(date: Date(), tasks: [])).previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
