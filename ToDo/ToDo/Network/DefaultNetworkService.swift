import Foundation

//enum ApiErrors {
//    case invalidURL = NSError(domain: "invalidEndpoint", code: 404, userInfo: nil)
//}
enum ApiErrors: Error {
//    = NSError(domain: "invalidEndpoint", code: 404, userInfo: nil)
    case invalidURL
    case invalidData
    case noData
}

class DefaultNetworkService: NetworkService {
    private let baseURL = "https://beta.mrdekk.ru/todobackend"

    func auth(_ URLSuffix: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + URLSuffix) else {
            throw ApiErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        let token = "token"
        request.setValue("Bearer \(token) ", forHTTPHeaderField: "Authorization")
        
        return request
    }

    func getElement(by id: String) async throws -> TodoItem {
        var request = try auth(id)
        request.httpMethod = HTTPMethod.get.rawValue
        let (data, _) = try await URLSession.shared.dataTask(for: request)
        
        guard let item = TodoItem.parse(json: data) else { // надо не на главном потоке
            throw ApiErrors.invalidData
        }
        return item
    }
    
    func getData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + "/list") else {
            let error = NSError(
                domain: "invalidEndpoint",
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }

            guard let data = data else {
                let error = NSError(
                    domain: "noData",
                    code: 404, // каокй то другой
                    userInfo: nil
                )
                return completion(.failure(error))
            }

            return completion(.success(data))
        }

        task.resume()
    }

    func postData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL + "/list") else {
            let error = NSError(
                domain: "invalidEndpoint",
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { _, response, error in
           if let error = error {
               completion(.failure(error))
               return
           }

           completion(.success(()))
       }

       task.resume()
    }

    func putData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        <#code#>
    }

    func patchData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        <#code#>
    }

    func deleteData(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: baseURL + "/list") else {
            let error = NSError(
                domain: "invalidEndpoint",
                code: 404,
                userInfo: nil
            )
            return completion(.failure(error))
        }

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue

        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            completion(.success(()))
        }

        task.resume()
    }
}
