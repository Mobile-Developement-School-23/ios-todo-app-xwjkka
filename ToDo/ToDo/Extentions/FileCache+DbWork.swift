//
//  FileCache+DbWork.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 12.07.2023.
//

import Foundation
import SQLite

extension FileCache {
    
    var sqlReplaceStatement: String {
        var sqlReplaceStatement = "REPLACE INTO \"listToDo\" (id, text, importance, deadline, done, created, changed) VALUES \n"
        for index in 0..<ListToDo.count {
            let item = ListToDo[index]
            sqlReplaceStatement += "('\(item.id)', '\(item.text)', '\(item.importance)', '\(String(describing: item.deadline))', '\(item.done)', '\(item.created)', '\(String(describing: item.changed))')"
            if index != ListToDo.count - 1 {
                sqlReplaceStatement += ",\n"
            }
        }
        sqlReplaceStatement += ";"
        if ListToDo.count == 0 {
            sqlReplaceStatement = "DROP table listToDo"
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
//            print(sqlReplaceStatement)
            try db.run(sqlReplaceStatement)
            
        } catch {
            print(error)
        }
    }

//    func insertToDb(item: TodoItem) {
//        do {
//            let db = try makeDb()
//            let insert = db.insert(or: .replace,
//                                        db.listToDo.id <- item.id,
//                                        db.listToDo.text <- item.text)
//            try db.run(insert)
//        } catch {
//            print("Failed to insert item: \(error)")
//        }
//    }
//
//    func updateToDb(item: TodoItem) {
//        do {
//            let filter = self.items.filter(self.id == item.id)
//            let update = filter.update(self.name <- item.name)
//            try db.run(update)
//        } catch {
//            print("Failed to update item: \(error)")
//        }
//    }
//
//    func deleteToDb(item: TodoItem) {
//        do {
//            let deleted = self.items.filter(self.id == item.id)
//            let delete = deleted.delete()
//            try db.run(delete)
//        } catch {
//            print("Failed to delete item: \(error)")
//        }
//    }


    func loadFromDb() {
        do {
            let db = try makeDb()
            
            let listToDo = Table("listToDo")
            let id = Expression<String>("id")
            let text = Expression<String>("text")
            let importance = Expression<String>("importance")
            let deadline = Expression<Date?>("deadline")
            let done = Expression<String>("done")
            let created = Expression<Date>("created")
            let changed = Expression<Date?>("changed")
            
            
            for row in try db.prepare(listToDo) {
//                print(row)
//                print(row[done])
                var doneBool = false
                if row[done] == "true" {
                    doneBool = true
                }
                let item = TodoItem(id: row[id], text: row[text], importance: Importance(rawValue: row[importance] ) ?? .regular, deadline: Date(), done: doneBool, created: Date(), changed: Date())
                self.addToDo(item)
            }
            
        } catch {
            print("Failed to load items: \(error)")
        }
    }
}
