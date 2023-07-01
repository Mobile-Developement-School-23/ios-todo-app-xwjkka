import Foundation

class FileCache {
    private (set) var ListToDo: [TodoItem] = []
    
    func addToDo(_ item: TodoItem) {
        if let index = ListToDo.firstIndex(where: { $0.id == item.id }) {
            ListToDo[index] = item
        } else {
            ListToDo.append(item)
        }
    }
    
    func deleteToDo(_ id: String) {
        ListToDo.removeAll(where: { $0.id == id })
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
                                self.addToDo(ToDoItem)
                            }
                        }
                    }
                    
                } catch {
                    print("Error loading items from file: \(error)")
                }
                
            }
        }
    }
    
    func saveToFileCSV(path: String = "ListToDo.csv") -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let pathURL = documentDirectory.appendingPathComponent(path)
        
        do {
            var fileCSV = "id;text;importance;deadline;done;created;changed;\n"
            fileCSV += ListToDo.map({ $0.csv }).joined(separator: "\n")
            try fileCSV.write(to: pathURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving file: \(error)")
        }
        
        return pathURL
    }
    
    func loadFromFileCSV(paths: [String]) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            for i in paths {
                let filePath = documentDirectory.appendingPathComponent(i)
                
                do {
                    let fileCSV = try String(contentsOf: filePath)
                    var rowsCSV = fileCSV.split(separator: "\n").map{ String($0) }
                    rowsCSV.removeFirst()
                    
                    for item in rowsCSV {
                        if let ToDoItem = TodoItem.parse(csv: item) {
                            self.addToDo(ToDoItem)
                        }
                    }
                } catch {
                    print("Error loading items from file: \(FileCacheError.dataParsingFailed)")
                }
                
            }
        }
    }
}
