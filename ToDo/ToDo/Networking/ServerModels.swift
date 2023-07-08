//
//  DefaultNetworkingService.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 08.07.2023.
//

import Foundation

struct ServerRequestList: Codable {
    let status: String
    let list: [ServerElement]
}

struct ServerResponseList: Codable {
    let status: String
    let list: [ServerElement]
    let revision: Int
}

struct ServerRequestElement: Codable {
    let status: String
    let element: ServerElement
}

struct ServerResponseElement: Codable {
    let status: String
    let element: ServerElement
    let revision: Int
}

struct ServerElement: Codable {
    let id: String
    let text: String
    let importance: String
    let deadline: Int?
    let done: Bool
    let color: String?
    let created: Int
    let changed: Int?
    let lastUpdatedBy: String
    
    init(id: String, text: String, importance: String, deadline: Int? = nil, done: Bool = false, color: String? = nil, created: Int = Int(Date().timeIntervalSince1970), changed: Int? = nil, lastUpdatedBy: String) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.done = done
        self.color = color
        self.created = created
        self.changed = changed
        self.lastUpdatedBy = lastUpdatedBy
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case importance
        case deadline
        case done
        case color
        case created = "created_at"
        case changed = "changed_at"
        case lastUpdatedBy = "last_updated_by"
    }
}
