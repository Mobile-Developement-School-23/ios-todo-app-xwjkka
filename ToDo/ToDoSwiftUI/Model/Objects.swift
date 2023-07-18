import Foundation

enum Importance: String, CaseIterable {
    case unimportant = "unimportant"
    case regular = "regular"
    case important = "important"
}

struct TodoItem: Identifiable {
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

// for work with file
enum FileCacheError: Error {
    case fileNotFound
    case dataReadingFailed
    case dataParsingFailed
}
