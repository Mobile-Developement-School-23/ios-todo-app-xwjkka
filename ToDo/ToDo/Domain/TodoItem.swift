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
        
        var deadline: Date?
        if let deadlineTimestamp = json["deadline"] as? Double {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        }
        
        var changed: Date?
        if let changedTimestamp = json["changed"] as? Double {
            changed = Date(timeIntervalSince1970: changedTimestamp)
        }
        
        item = TodoItem.init(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
        return item
    }

}

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
        var csvStr = csvComponents.joined(separator: ";")
        csvStr.append("\n")
        return csvStr
    }

    private static func splitCSV(csv: String) -> [String]? {
        var csvComponents = [String]()
        for var i in 0..<csv.count {
            var temp: String = ""
            if csv[csv.index(csv.startIndex, offsetBy: i)] == ";" || i == 0 {
                if i != 0 {
                    i += 1
                }
                while (i < csv.count && csv[csv.index(csv.startIndex, offsetBy: i)] != ";") {
                    temp += String(csv[csv.index(csv.startIndex, offsetBy: i)])
                    i += 1
                }
                i += 1
                csvComponents.append(temp)
            }
        }
        
        if csvComponents.count != 7 {
            return nil
        }
        
        return csvComponents
    }
    
    static func parse(csv: String) -> TodoItem? {
        var item: TodoItem?
        if let csvComponents = splitCSV(csv: csv) {
            guard !csvComponents[1].isEmpty,
                  let done = Bool(csvComponents[4]),
                  let createdTimestamp = Double(csvComponents[5])
            else {
                return nil
            }
            
            var id: String = ""
            if csvComponents[0].isEmpty {
                id = UUID().uuidString
            } else {
                id = csvComponents[0]
            }
            
            let text = csvComponents[1]
            
            var importance: Importance
            if csvComponents[2].isEmpty {
                importance = .regular
            } else {
                importance = Importance(rawValue: csvComponents[2]) ?? .regular
            }
            
            var deadline: Date?
            if !csvComponents[3].isEmpty {
                deadline = Date(timeIntervalSince1970: Double(csvComponents[3]) ?? 0)
            }
            
            let created = Date(timeIntervalSince1970: createdTimestamp)
            
            var changed: Date?
            if !csvComponents[6].isEmpty {
                changed = Date(timeIntervalSince1970: Double(csvComponents[6]) ?? 0)
            }
            
            item = TodoItem.init(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
            
            return item
        } else {
            return nil
        }
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
