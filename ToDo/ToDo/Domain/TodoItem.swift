import Foundation

enum Importance: String {
    case unimportant = "unimportant"
    case regular = "regular"
    case important = "important"
}

extension TodoItem {
//    var json: Any

    static func parse(json: Any) -> TodoItem? {
        var data = Data(); var item: TodoItem?
        if let jsonString = json as? String {
            data = Data(jsonString.utf8)
        } else if let jsonData = json as? Data {
            data = jsonData
        }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                item = try TodoItem.init(id: json["id"] as? String, text: json["text"] as! String, importance: json["importance"] as! String, deadline: json["deadline"] as? Date, done: json["done"] as! Bool, created: json["created"] as! Date, changed: json["changed"] as? Date)
                
//                guard let id = json["id"] as String else{
//                    let id
//                }

//                item = try TodoItem.init(id: json["id"] as? String ?? UUID().uuidString, text: json["text"] as! String, importance: Importance.unimportant, deadline: json["deadline"] as? Date ?? nil, done: json["done"] as? Bool ?? false, created: json["created"] as! Date, changed: json["changed"] as? Date ?? nil)
            } else {
                print("Invalid JSON")
                item = nil
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
            item = nil
        }
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
    
    init(id: String? = nil, text: String, importance: String, deadline: Date? = nil, done: Bool, created: Date, changed: Date? = nil) {
        if let id = id {
            self.id = id
        } else {
            self.id = UUID().uuidString
        }
        self.text = text
        
        if let importance = Importance(rawValue: importance) {
            self.importance = importance
        } else {
            self.importance = Importance.regular
        }
        
        self.deadline = deadline
        self.done = done
        self.created = created
        self.changed = changed
    }
}

//class FileCache {
//
//}
let j = "{\"id\": \"12345\",\"text\": \"Сделать домашнее задание\", \"importance\": \"important\", \"deadline\": \"2022-05-30T12:00:00Z\", \"done\": false, \"created\": \"2022-05-28T08:30:00Z\", \"changed\": \"2022-05-29T14:20:00Z\" }"
let item: TodoItem = TodoItem.parse(json: j)!
print(item)
