//
//  TodoItemConverter.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 08.07.2023.
//

import Foundation
import UIKit

final class TodoItemConverter {
    
    static func convertTodoItemToServerElement(_ item: TodoItem) -> ServerElement {
        
        var importance = "basic"
        if item.importance.rawValue == "unimportant" {
            importance = "low"
        } else if item.importance.rawValue == "important" {
            importance = "important"
        }
        
        var deadline: Int?
        if let deadlineDouble = item.deadline?.timeIntervalSince1970 {
            deadline = Int(deadlineDouble)
        }
        
        
        var changed = 0
        if let changedDouble = item.changed?.timeIntervalSince1970 {
            changed = Int(changedDouble)
        }
        
        let lastUpdatedBy = UIDevice.current.identifierForVendor?.uuidString ?? "iPhone"
        
        return ServerElement(id: item.id, text: item.text, importance: importance, deadline: deadline, done: item.done, color: "#FFFFFF", created: Int(item.created.timeIntervalSince1970), changed: changed, lastUpdatedBy: lastUpdatedBy)
    }
    
    static func convertServerElementToTodoItem(_ element: ServerElement) -> TodoItem {
        let id = element.id
        let text = element.text
//        let priority = Priority(rawValue: element.priority) ?? .basic
        var importance = Importance.regular
        if element.importance == "low" {
            importance = .unimportant
        } else if element.importance == "important" {
            importance = .important
        }
        var deadline: Date?
        if let deadlineInt = element.deadline {
            deadline = Date(timeIntervalSince1970: TimeInterval(deadlineInt))
        }
        let done = element.done
        let created = Date(timeIntervalSince1970: TimeInterval(element.created))
        var changed: Date?
        if let changedInt = element.changed {
            changed = Date(timeIntervalSince1970: TimeInterval(changedInt))
        }
        
        return TodoItem(id: id, text: text, importance: importance, deadline: deadline, done: done, created: created, changed: changed)
    }
    
    static func convertServerListToTodoItemsList(_ serverList: [ServerElement]) -> [TodoItem] {
        var items: [TodoItem] = []
        serverList.forEach { element in
            let item = convertServerElementToTodoItem(element)
            items.append(item)
        }
        return items
    }
    
    static func convertTodoItemsListToServerList(_ todoItemsList: [TodoItem]) -> [ServerElement] {
        var elements: [ServerElement] = []
        todoItemsList.forEach { item in
            let element = convertTodoItemToServerElement(item)
            elements.append(element)
        }
        return elements
    }
    
}
