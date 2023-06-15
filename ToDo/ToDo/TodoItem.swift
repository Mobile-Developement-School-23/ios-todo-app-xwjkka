import Foundation

enum Importance: String, CaseIterable {
    case unimportant = "unimportant"
    case regular = "regular"
    case important = "important"
}

extension TodoItem {
    var json: Any {
        var dict: [String: Any] = ["id": self.id,
                                   "text": self.text,
                                   "done": self.done,
                                   "created": self.created.timeIntervalSince1970]
        if self.importance != .regular {
            dict["importance"] = self.importance.rawValue
        }
        if let deadline = self.deadline {
            dict["deadline"] = deadline.timeIntervalSince1970
        }
        if let changed = self.changed {
            dict["changed"] = changed.timeIntervalSince1970
        }
        return dict
    }

    static func parse(json: Any) -> TodoItem? {
        var item: TodoItem?
        guard let json = json as? [String: Any] else {
            return nil
        }
        
        guard let text = json["text"] as? String,
              let done = json["done"] as? Bool,
              let createdTimestamp = json["created"] as? Double
        else {
            return nil
        }
        let id = json["id"] as? String ?? UUID().uuidString
        let created =  Date(timeIntervalSince1970: createdTimestamp)

        var importance = Importance.regular
        if let importanceStr = json["importance"] as? String {
            importance = Importance(rawValue: importanceStr) ?? Importance.regular
        }
        
        let deadline: Date?
        if let deadlineTimestamp = json["deadline"] as? Double {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        } else {
            deadline = nil
        }
        
        let changed: Date?
        if let changedTimestamp = json["changed"] as? Double {
            changed = Date(timeIntervalSince1970: changedTimestamp)
        } else {
            changed = nil
        }
        
        item = TodoItem.init(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
        return item
    }

}

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let done: Bool
    let created: Date
    let changed: Date?

    init(id: String, text: String, importance: Importance, deadline: Date?, done: Bool, created: Date, changed: Date?) {
            self.id = id
            self.text = text
            self.importance = importance
            self.deadline = deadline
            self.done = done
            self.created = created
            self.changed = changed
    }
}
