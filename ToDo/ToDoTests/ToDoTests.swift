import XCTest
@testable import ToDo

class ToDoTests: XCTestCase {

    func testToDoItemParse1() throws {
        let j: [String: Any] = ["id": "12345",
                                "text": "Сделать домашнее задание",
                                "importance": "important",
                                "deadline": 2022.0,
                                "done": false,
                                "created": 2022.0,
                                "changed": 2022.0]
        
        let id = "12345"; let text = "Сделать домашнее задание"; let done = false;
        let importance: Importance = .important
        let deadline = Date(timeIntervalSinceNow: 2022.0)
        let created = Date(timeIntervalSinceNow: 2022.0)
        let changed = Date(timeIntervalSinceNow: 2022.0)
        
        let item: TodoItem = TodoItem.parse(json: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.deadline, deadline)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
        XCTAssertEqual(item.changed, changed)
    }
    
    func testToDoItemParse2() throws {
        let j: [String: Any] = ["id": "1",
                                "text": "String",
                                "importance": "important",
                                "done": true,
                                "created": 1234.0]
        let id = "1"; let text = "String"; let done = true;
        let importance: Importance = .important
        let created = Date(timeIntervalSinceNow: 1234.0)
        
        let item: TodoItem = TodoItem.parse(json: j)!
    
        XCTAssertEqual(item.id, id)
        XCTAssertEqual(item.text, text)
        XCTAssertEqual(item.importance, importance)
        XCTAssertEqual(item.done, done)
        XCTAssertEqual(item.created, created)
    }
    
    func testTodoItemParseError() {
        let json = ["id": "123",
                    "text": "haha",
                    "importance": "invalid",
                    "done": false] as [String : Any]
        
        let item = TodoItem.parse(json: json)
        
        XCTAssertNil(item)
    }
}
