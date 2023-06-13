import Foundation

enum Importance {
    case unimportant;
    case regular;
    case important;
}

extension TodoItem {
//    var json: Any

    static func parse(json: Data) -> TodoItem? {
//        if let jsonString =
        do {
            if let json = try JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
                if let text = json["text"] as? String {
                    print(text)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
//        let item = TodoItem(text: json[text], deadline: json[dea], done: json, created: json, changed: nil)
        let item = TodoItem.init(text: "String", importance: Importance.important, deadline: nil, done: true, created: nil, changed: nil)
        return item
    }

}

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let done: Bool
//    let created: Date
    let created: Date?
    let changed: Date?
    
    init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date? = nil, done: Bool = false, created: Date? = nil, changed: Date? = nil) {
            self.id = id
            self.text = text
            self.importance = importance
            self.deadline = deadline
            self.done = done
            self.created = created
            self.changed = changed
    }
}

//class FileCache {
//
//}
let j = "{\"id\": \"12345\",\"text\": \"Сделать домашнее задание\", \"importance\": \"важная\", \"deadline\": \"2022-05-30T12:00:00Z\", \"isDone\": false, \"creationDate\": \"2022-05-28T08:30:00Z\", \"modificationDate\": \"2022-05-29T14:20:00Z\" }"
let data = Data(j.utf8)
let item = TodoItem.parse(json: data)
print(item)
