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
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), task: TaskModel(id: UUID(), title: "task", note: "SimpleNote", completed: false))
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let tasksUncompleted = CoreDataManager.sharedInstance.fetchAllTask().map(TaskModel.init)
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        for i in 0 ..< tasksUncompleted.count {
            let entryDate = DateUtils.getDateFromString(for: tasksUncompleted[i].dueDate)?.addingTimeInterval(-6200)
            let entry = SimpleEntry(date: entryDate ?? Date(), task: tasksUncompleted[i])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let task: TaskModel
//    public let configuration: ConfigurationIntent
}

struct PlaceholderView : View {
    var body: some View {
        TaskWidgetEntryView(entry: SimpleEntry(date: Date(), task: TaskModel(id: UUID(), title: "Task", note: "Note", completed: false)))
    }
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
          HStack {
            Text(entry.task.title ?? "")
              .font(.system(size: 30))
              .padding()
          }
        }
    }
}

@main
struct TaskWidget: Widget {
    private let kind: String = "TaskWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            TaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TaskWidget_Previews: PreviewProvider {
    static var previews: some View {
        TaskWidgetEntryView(entry: SimpleEntry(date: Date(), task: TaskModel(id: UUID(), title: "Task", note: "Note", completed: false)))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
