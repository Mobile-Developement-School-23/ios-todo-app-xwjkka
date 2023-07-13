//
//  FileCache+DbWork.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 12.07.2023.
//

import Foundation
import SQLite

extension FileCache {
    
    var sqlReplaceStatement: String {  // честно это очень не удобно тк возвращать стоит не str
//        var sqlReplaceStatement = "REPLACE INTO \"listToDo\" (id, text, importance, deadline, done, created, changed) VALUES \n"
//        for index in 0..<ListToDo.count {
//            let item = ListToDo[index]
//            sqlReplaceStatement += "('\(item.id)', '\(item.text)', '\(item.importance)', '\(String(describing: item.deadline))', '\(item.done)', '\(item.created)', '\(String(describing: item.changed))')"
//            if index != ListToDo.count - 1 {
//                sqlReplaceStatement += ",\n"
//            }
//        }
//        sqlReplaceStatement += ";"
//        if ListToDo.count == 0 {
//            sqlReplaceStatement = "DROP table listToDo"
//        }
        var sqlReplaceStatement = String()
        
        let listToDo = Table("listToDo")
        let id = Expression<String>("id")
        let text = Expression<String>("text")
        let importance = Expression<String>("importance")
        let deadline = Expression<Date?>("deadline")
        let done = Expression<Bool?>("done")
        let created = Expression<Date>("created")
        let changed = Expression<Date?>("changed")
        
        for item in ListToDo {
            let replace = listToDo.insert(or: .replace,
                                         id <- item.id,
                                         text <- item.text,
                                         importance <- item.importance.rawValue,
                                         deadline <- item.deadline,
                                         done <- item.done,
                                         created <- item.created,
                                         changed <- item.changed)
            sqlReplaceStatement += "\(replace);"
        }
        return sqlReplaceStatement
    }
    
    func makeDb() throws -> Connection {
        do {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw NSError()
            }
            let db = try Connection("\(documentDirectory)/db.sqlite3")


            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            let text = Expression<String>("text")
            let importance = Expression<String>("importance")
            let deadline = Expression<Date?>("deadline")
            let done = Expression<Bool?>("done")
            let created = Expression<Date>("created")
            let changed = Expression<Date?>("changed")

//            try db.run(listToDo.drop(ifExists: true))
            try db.run(listToDo.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(text)
                table.column(importance)
                table.column(deadline)
                table.column(done)
                table.column(created)
                table.column(changed)
                })

            return db
        } catch {
            throw error
        }
    }
    
    func saveToDb() {
        do {
            
            let db = try makeDb()
            try db.run(sqlReplaceStatement)
            
        } catch {
            print(error)
        }
    }

    func insertToDb(item: TodoItem) {
        do {
            let db = try makeDb()
            
            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            let text = Expression<String>("text")
            let importance = Expression<String>("importance")
            let deadline = Expression<Date?>("deadline")
            let done = Expression<Bool>("done")
            let created = Expression<Date>("created")
            let changed = Expression<Date?>("changed")
            
            let insert = listToDo.insert(or: .replace,
                                         id <- item.id,
                                         text <- item.text,
                                         importance <- item.importance.rawValue,
                                         deadline <- item.deadline,
                                         done <- item.done,
                                         created <- item.created,
                                         changed <- item.changed)
//            print(insert.type)
            try db.run(insert)
        } catch {
            print("Failed to insert item: \(error)")
        }
    }

    func updateToDb(item: TodoItem) {
        do {
            let db = try makeDb()
            
            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            let text = Expression<String>("text")
            let importance = Expression<String>("importance")
            let deadline = Expression<Date?>("deadline")
            let done = Expression<Bool>("done")
            let created = Expression<Date>("created")
            let changed = Expression<Date?>("changed")
            
            let updated = listToDo.filter(id == item.id)
            let update = updated.update(text <- item.text,
                                        importance <- item.importance.rawValue,
                                        deadline <- item.deadline,
                                        done <- item.done,
                                        created <- item.created,
                                        changed <- item.changed)

            try db.run(update)
        } catch {
            print("Failed to update item: \(error)")
        }
    }

    func deleteFromDb(itemId: String) {
        do {
            let db = try makeDb()
            
            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            
            let deleted = listToDo.filter(id == itemId)
            let delete = deleted.delete()
            try db.run(delete)
        } catch {
            print("Failed to delete item: \(error)")
        }
    }


    func loadFromDb() {
        do {
            let db = try makeDb()
            
            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            let text = Expression<String>("text")
            let importance = Expression<String>("importance")
            let deadline = Expression<Date?>("deadline")
            let done = Expression<Bool>("done")
            let created = Expression<Date>("created")
            let changed = Expression<Date?>("changed")
            
            
            for row in try db.prepare(listToDo) {
                let item = TodoItem(id: row[id], text: row[text], importance: Importance(rawValue: row[importance]) ?? .regular, deadline: row[deadline], done: row[done], created: row[created], changed: row[changed])
                self.addToDo(item)
            }
            
        } catch {
            print("Failed to load items: \(error)")
        }
    }
}
