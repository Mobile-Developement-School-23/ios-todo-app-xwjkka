//
//  DefaultNetworkingService.swift
//  ToDo
//
//  Created by Olesya Khurmuzakiy on 07.07.2023.
//

import Foundation

final class DefaultNetworkingService: NetworkingService {

    private static let baseURL = "https://beta.mrdekk.ru/todobackend"
    private static let token = "besmirch"
    private static var revision = 0

    
    private static func auth(URL url: URL, httpMethod: HTTPMethod, httpBody: Data? = nil) async throws -> (Data, HTTPURLResponse) {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("\(revision)", forHTTPHeaderField: "X-Last-Known-Revision")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw ApiErrors.invalidResponse
        }
        
        return (data, response)
    }
    
    static func getData() async throws -> [ServerElement] {
        let url = baseURL + "/list"
        guard let url = URL(string: url) else {
            throw ApiErrors.wrongUrl
        }
        let (data, _) = try await auth(URL: url, httpMethod: .get)
        let serverData = try JSONDecoder().decode(ServerResponseList.self, from: data)
        revision = serverData.revision
        return serverData.list
    }
    
    static func getDataById(id: String) async throws -> ServerElement {
        let urlSource = baseURL + "/list/\(id)"
        guard let url = URL(string: urlSource) else {
            throw ApiErrors.wrongUrl
        }
        let (data, _) = try await auth(URL: url, httpMethod: .get)
        let serverData = try JSONDecoder().decode(ServerResponseElement.self, from: data)
        return serverData.element
    }
    
    static func postData(list: [ServerElement]) async throws -> [ServerElement] {
        let url = baseURL + "/list"
        guard let url = URL(string: url) else {
            throw ApiErrors.wrongUrl
        }
        let request = ServerRequestList(status: "ok", list: list)
        let httpBody = try JSONEncoder().encode(request)
        let (data, _) = try await auth(URL: url, httpMethod: .patch, httpBody: httpBody)
        let serverData = try JSONDecoder().decode(ServerResponseList.self, from: data)
        revision += 1
        return serverData.list
    }
    
    static func putData(item: ServerElement) async throws -> ServerElement {
        let url = baseURL + "/list"
        guard let url = URL(string: url) else {
            throw ApiErrors.wrongUrl
        }
        let request = ServerRequestElement(status: "ok", element: item)
        let httpBody = try JSONEncoder().encode(request)
        let (data, _) = try await auth(URL: url, httpMethod: .post, httpBody: httpBody)
        let serverData = try JSONDecoder().decode(ServerResponseElement.self, from: data)
        revision += 1
        return serverData.element
    }
    
    static func patchData(id: String, item: ServerElement) async throws -> ServerElement {
        let urlSource = baseURL + "/list/\(id)"
        guard let url = URL(string: urlSource) else {
            throw ApiErrors.wrongUrl
        }
        let request = ServerRequestElement(status: "ok", element: item)
        let httpBody = try JSONEncoder().encode(request)
        let (data, _) = try await auth(URL: url, httpMethod: .put, httpBody: httpBody)
        let serverData = try JSONDecoder().decode(ServerResponseElement.self, from: data)
        revision += 1
        return serverData.element
    }

    static func deleteData(id: String) async throws -> ServerElement {
        let urlSource = baseURL + "/list/\(id)"
        guard let url = URL(string: urlSource) else {
            throw ApiErrors.wrongUrl
        }
        let (data, _) = try await auth(URL: url, httpMethod: .delete)
        let serverData = try JSONDecoder().decode(ServerResponseElement.self, from: data)
        revision += 1
        return serverData.element
    }
}
