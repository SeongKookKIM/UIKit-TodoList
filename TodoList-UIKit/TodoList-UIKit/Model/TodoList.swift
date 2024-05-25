

import UIKit


class TodoListEntry {
    let title: String
    let date: String
    let content: String
    
    init(title: String, date: String, content: String) {
        self.title = title
        self.date = date
        self.content = content
    }
}


struct SampleTodoListData {
    var todoListEntries: [TodoListEntry] = []
    
    mutating func createSampleTodoListEntryData() {
        let sample1 = TodoListEntry(title: "Saple1", date: String(describing: Date().formatted(.dateTime.year().month().day())), content: "Sample Content")
        let sample2 = TodoListEntry(title: "Saple2", date: String(describing: Date().formatted(.dateTime.year().month().day())), content: "Sample Content")
        let sample3 = TodoListEntry(title: "Saple3", date: String(describing: Date().formatted(.dateTime.year().month().day())), content: "Sample Content")
        
        todoListEntries += [sample1, sample2, sample3]
    }

}
