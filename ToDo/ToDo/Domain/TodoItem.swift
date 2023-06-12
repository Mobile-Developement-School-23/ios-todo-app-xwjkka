import Foundation

enum Importance {
    case unimportant;
    case regular;
    case important;
}

//extension TodoItem {
//    var json: Any
//
//    static func parse(json: Any) -> TodoItem? {
//        guard let parsedJson = JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
//            return
//        }
//
//        let item = TodoItem(text: parsedJson[text], deadline: parsedJson[], done: parsedJson, created: parsedJson, changed: parsedJson[])
//    }
//
//}

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let done: Bool
    let created: Date
    let changed: Date?
    
    init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date? = nil, done: Bool = false, created: Date = Date(), changed: Date? = nil) {
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
