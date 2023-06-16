import XCTest
@testable import ToDo

class ToDoTests: XCTestCase {

    func testToDoItemParseJSON1() throws {
        let j: [String: Any] = ["id": "12345",
                                "text": "Сделать домашнее задание",
                                "importance": "important",
                                "deadline": 2022.0,
                                "done": false,
                                "created": 2022.0,
                                "changed": 2022.0]
        
        let id = "12345"; let text = "Сделать домашнее задание"; let done = false;
        let importance: Importance = .important
        let deadline = Date(timeIntervalSince1970: 2022.0)
        let created = Date(timeIntervalSince1970: 2022.0)
        let changed = Date(timeIntervalSince1970: 2022.0)
        
        let item: TodoItem = TodoItem.parse(json: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.deadline, deadline)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
        XCTAssertEqual(item.changed, changed)
    }
    
    func testToDoItemParseJSON2() throws {
        let j: [String: Any] = ["id": "1",
                                "text": "String",
                                "importance": "important",
                                "done": true,
                                "created": 1234.0]
        let id = "1"; let text = "String"; let done = true;
        let importance: Importance = .important
        let created = Date(timeIntervalSince1970: 1234.0)
        
        let item: TodoItem = TodoItem.parse(json: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
    }
    
    func testToDoItemParseJSON3() throws {
        let j: [String: Any] = ["text": "String",
                                "importance": "unimportant",
                                "done": true,
                                "created": 1234.0]
        let text = "String"; let done = true;
        let importance: Importance = .unimportant
        let created = Date(timeIntervalSince1970: 1234.0)
        
        let item: TodoItem = TodoItem.parse(json: j)!
        
        XCTAssertNotNil(item.id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
    }
    
    func testTodoItemParseJSONError() {
        let json = ["id": "123",
                    "text": "haha",
                    "importance": "invalid",
                    "done": false] as [String : Any]
        
        let item = TodoItem.parse(json: json)
        
        XCTAssertNil(item)
    }
    
    
    func testToDoItemParseCSV1() throws {
        let j: String = "12345;Сделать домашнее задание;important;2022.0;false;2022.0;2022.0"
        
        let id = "12345"; let text = "Сделать домашнее задание"; let done = false;
        let importance: Importance = .important
        let deadline = Date(timeIntervalSince1970: 2022.0)
        let created = Date(timeIntervalSince1970: 2022.0)
        let changed = Date(timeIntervalSince1970: 2022.0)
        
        let item: TodoItem = TodoItem.parse(csv: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.deadline, deadline)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
        XCTAssertEqual(item.changed, changed)
    }
    
    func testToDoItemParseCSV2() throws {
        let j: String = "1;String;important;;true;1234.0;"
        let id = "1"; let text = "String"; let done = true;
        let importance: Importance = .important
        let created = Date(timeIntervalSince1970: 1234.0)
        
        let item: TodoItem = TodoItem.parse(csv: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
    }
    
//    func testToDoItemParseCSV3() throws {
//        let j: String = ";String;unimportant;;true;1234.0;"
//        let text = "String"; let done = true;
//        let importance: Importance = .unimportant
//        let created = Date(timeIntervalSince1970: 1234.0)
//
//        let item: TodoItem = TodoItem.parse(csv: j)!
//
//        XCTAssertNotNil(item.id)
//        XCTAssertEqual(item.text, text)
//        XCTAssertEqual(item.importance, importance)
//        XCTAssertEqual(item.done, done)
//        XCTAssertEqual(item.created, created)
//    }
    
    func testTodoItemParseCSVrror() {
        let j: String = "123;haha;invalid;;;;;"
        
        let item = TodoItem.parse(csv: j)
        
        XCTAssertNil(item)
    }
    
    func testTodoItemInit1() {
        let item = TodoItem.init(text: "make smthg", importance: .regular, created: Date(timeIntervalSince1970: 2022.0))
        let text = "make smthg"; let importance = Importance.regular; let created = Date(timeIntervalSince1970: 2022.0)
        XCTAssertNotNil(item.id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.created, created)
    }
    
    func testTodoItemInit2() {
        let item = TodoItem.init(id: "12345", text: "chill", importance: .important,
                                 deadline: Date(timeIntervalSince1970: 2022.0),
                                 done: true,
                                 created: Date(timeIntervalSince1970: 2022.0),
                                 changed: Date(timeIntervalSince1970: 2022.0))
        let id = "12345"; let text = "chill"; let importance = Importance.important; let done = true
        let deadline = Date(timeIntervalSince1970: 2022.0);
        let created = Date(timeIntervalSince1970: 2022.0);
        let changed = Date(timeIntervalSince1970: 2022.0);
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.deadline, deadline)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
        XCTAssertEqual(item.changed, changed)
    }
}
