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

class FileCache {
    private (set) var ListToDo: [TodoItem] = []
    
    func addToDo(TodoItem: TodoItem) {
        if let index = ListToDo.firstIndex(where: { $0.id == TodoItem.id }) {
            ListToDo[index] = TodoItem
        } else {
            ListToDo.append(TodoItem)
        }
    }

    func deleteToDo(TodoItem: TodoItem) {
        if let index = ListToDo.firstIndex(where: { $0.id == TodoItem.id }) {
            ListToDo.remove(at: index)
        }
    }
    
    func saveToFile(path: String = "ListToDo.json") -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let pathURL = documentDirectory.appendingPathComponent(path)

        do {
            var arrayToDoJson =  Array<Any>()
            for item in self.ListToDo {
                arrayToDoJson.append(item.json)
            }
            if let dataJson = try? JSONSerialization.data(withJSONObject: arrayToDoJson, options: .prettyPrinted) {
                try dataJson.write(to: pathURL)
            }
        } catch {
            print("Error saving file: ")
        }

        return pathURL
    }

    func loadFromFile(paths: [String]) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            for i in paths {
                let filePath = documentDirectory.appendingPathComponent(i)
                
                do {
                    let data = try Data(contentsOf: filePath, options: .mappedIfSafe)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonArr = json as? [Any] {
                        for item in jsonArr {
                            if let ToDoItem = TodoItem.parse(json: item) {
                                self.addToDo(TodoItem: ToDoItem)
                            }
                        }
                    }

                } catch {
                    print("Error loading items from file: \(error)")
                }

            }
        }
    }
}

let j: [String: Any] = ["id": "12345",
                        "text": "Сделать домашнее задание",
                        "importance": "important",
                        "deadline": 2022.0,
                        "done": false,
                        "created": 2022.0,
                        "changed": 2022.0]

var j2: [String: Any]  = ["id": "1",
                          "text": "String",
                          "importance": "important",
                          "done": true,
                          "created": 1234.0]
let item: TodoItem? = TodoItem.parse(json: j)
let item2: TodoItem? = TodoItem.parse(json: j2)
//
//print(item)
//print(item2)
var a = FileCache()
a.loadFromFile(paths: ["ListToDo.json"])
print(a.ListToDo)
//if let item = item, let item2 = item2 {
//    a.addToDo(TodoItem: item)
//    a.addToDo(TodoItem: item2)
//    print(a.saveToFile())
//}
