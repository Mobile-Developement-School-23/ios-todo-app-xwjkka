import Foundation

enum Importance: String, CaseIterable {
    case unimportant = "unimportant"
    case regular = "regular"
    case important = "important"
}

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let done: Bool
    let created: Date
    let changed: Date?

    init(id: String = UUID().uuidString, text: String,
         importance: Importance, deadline: Date? = nil, done: Bool = false,
         created: Date, changed: Date? = nil) {
            self.id = id
            self.text = text
            self.importance = importance
            self.deadline = deadline
            self.done = done
            self.created = created
            self.changed = changed
    }
}

// for csv format
//enum Keys: Int {
//   case id = 0
//   case text = 1
//   case importance = 2
//   case deadline = 3
//   case is_completed = 4
//   case created_date = 5
//   case date_of_change = 6
//}

// for work with file
enum FileCacheError: Error {
    case fileNotFound
    case dataReadingFailed
    case dataParsingFailed
}
