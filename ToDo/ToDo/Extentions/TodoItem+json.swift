import Foundation

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
        guard let json = json as? [String: Any] else {
            return nil
        }
        
        guard let id = json["id"] as? String,
              let text = json["text"] as? String,
              let createdTimestamp = json["created"] as? Double
        else {
            return nil
        }
        let created =  Date(timeIntervalSince1970: createdTimestamp)

        var importance = Importance.regular
        if let importanceStr = json["importance"] as? String {
            importance = Importance(rawValue: importanceStr) ?? Importance.regular
        }
        
        var deadline: Date?
        if let deadlineTimestamp = json["deadline"] as? Double {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        }
        let done = (json["done"] as? Bool) ?? false
    
        var changed: Date?
        if let changedTimestamp = json["changed"] as? Double {
            changed = Date(timeIntervalSince1970: changedTimestamp)
        }
        
        return TodoItem.init(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
    }

}
