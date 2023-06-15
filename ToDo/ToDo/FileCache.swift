import Foundation

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
