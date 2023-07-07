import Foundation

extension TodoItem {
    var csv: String {
        var importance = ""; var deadlineStr = ""; var changedStr = ""
        if self.importance != Importance.regular {
            importance = self.importance.rawValue
        }
        if let deadline = self.deadline {
            deadlineStr = String(deadline.timeIntervalSince1970)
        }
        if let changed = self.changed {
            changedStr = String(changed.timeIntervalSince1970)
        }
        
        let csvComponents = [id, text, importance,
                             deadlineStr,
                             String(done),
                             String(created.timeIntervalSince1970),
                             changedStr] as [String]
        return csvComponents.joined(separator: ";")
    }
    
    static func parse(csv: String) -> TodoItem? {
        let csvComponents = csv.components(separatedBy: ";")
        guard csvComponents.count == 7,
              !csvComponents[1].isEmpty,
              let createdTimestamp = Double(csvComponents[5])
        else {
            return nil
        }
        
        let id = csvComponents[0]
        let text = csvComponents[1]
        let importance = Importance(rawValue: csvComponents[2]) ?? .regular
        let done = Bool(csvComponents[4]) ?? false
        
        var deadline: Date?
        if !csvComponents[3].isEmpty {
            deadline = Date(timeIntervalSince1970: Double(csvComponents[3]) ?? 0)
        }
        
        let created = Date(timeIntervalSince1970: createdTimestamp)
        
        var changed: Date?
        if !csvComponents[6].isEmpty {
            changed = Date(timeIntervalSince1970: Double(csvComponents[6]) ?? 0)
        }
        
        return TodoItem.init(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
    }
}
