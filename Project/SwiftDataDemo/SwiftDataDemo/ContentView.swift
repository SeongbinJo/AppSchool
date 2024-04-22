//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by 조성빈 on 4/22/24.
//

import SwiftUI
import SwiftData

@Model // SwiftData에 저장할 데이터의 모델 지정. @Model 안에 identifiable이 포함되어있음.
class Task: Equatable {
    var id: UUID
    var title: String
    var completed: Bool
    
    init(id: UUID = UUID(), title: String, completed: Bool = false) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}

struct ContentView: View {
    
    @Query(sort: \Task.title) var tasks: [Task]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Button(action: {
                            task.completed.toggle()
                        }) {
                            Image(systemName: task.completed ? "checkmark" : "circle")
                        }
                        Text(task.title)
                        if task.completed {
                            Spacer()
                            Image(systemName: "circle")
                        }
                    }
                    .swipeActions {
                        Button("Delete" , systemImage: "trash", role: .destructive) {
                            modelContext.delete(task)
                        }
                      }

                }
            }
            .navigationTitle("Task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addTask()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func addTask() {
        let newTask = Task(title: "Task #\(tasks.count + 1)")
        modelContext.insert(newTask)
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self)
}
