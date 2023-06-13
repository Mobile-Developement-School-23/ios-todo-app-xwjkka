import Foundation

enum Importance {
    case unimportant
    case regular
    case important
}

extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension TodoItem {
//    var json: Any

    static func parse(json: Any) -> TodoItem? {
        var data: Data; var item: TodoItem?
        if let jsonString = json as? String {
            data = Data(jsonString.utf8)
        } else {}
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                let item = TodoItem.init(text: "haha", importance: Importance.unimportant, created: DateFormatter.iso8601.date(from:"2022-05-29T14:20:00Z")!)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
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
    
    init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date? = nil, done: Bool = false, created: Date, changed: Date? = nil) {
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
//let j = "{\"id\": \"12345\",\"text\": \"Сделать домашнее задание\", \"importance\": \"important\", \"deadline\": \"2022-05-30T12:00:00Z\", \"done\": false, \"created\": \"2022-05-28T08:30:00Z\", \"changed\": \"2022-05-29T14:20:00Z\" }"
//let data = Data(j.utf8)
let item: TodoItem = TodoItem.parse(json: data)!
print(item)
