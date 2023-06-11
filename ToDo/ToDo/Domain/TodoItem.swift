enum Importance {
    case unimportant;
    case regular;
    case important;
}

extension TodoItem {
    var json: Any
    
    static func parse(json: Any) -> TodoItem? {
        guard let parsedJson = JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] {
            return
        }
        
        let item = TodoItem(text: parsedJson[text], deadline: parsedJson[], done: parsedJson, created: parsedJson, changed: parsedJson[])
    }
    
}

struct TodoItem {
    let id: Int = UUID().uuidString
    let text: String
    let importance: Importance = regular
    let deadline: Date?
    let done: Bool
    let created: Date
    let changed: Date?
}

class FileCache {
    
}
