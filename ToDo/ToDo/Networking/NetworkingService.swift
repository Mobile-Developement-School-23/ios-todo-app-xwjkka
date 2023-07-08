//
//  NetworkingService.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 07.07.2023.
//

import Foundation

protocol NetworkingService {
    static func getData() async throws -> [ServerElement]
    static func getDataById(id: String) async throws -> ServerElement
    static func postData(list: [ServerElement]) async throws -> [ServerElement]
    static func putData(item: ServerElement) async throws -> ServerElement
    static func patchData(id: String, item: ServerElement) async throws -> ServerElement
    static func deleteData(id: String) async throws -> ServerElement
}
