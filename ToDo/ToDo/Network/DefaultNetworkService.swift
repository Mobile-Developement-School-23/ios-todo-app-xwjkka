import Foundation

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
        let token = "besmirch"
        request.setValue("Bearer \\\(token) ", forHTTPHeaderField: "Authorization")
        
        return request
    }

    func getElement(by id: String) async throws -> TodoItem {
        var request = try auth("/list/\(id)")
        request.httpMethod = HTTPMethod.get.rawValue
        let (data, _) = try await URLSession.shared.dataTask(for: request)
        
//        DispatchQueue.main.async {
            guard let item = TodoItem.parse(json: data) else { // надо не на главном потоке
                throw ApiErrors.invalidData
            }
//        }
        return item
    }
    
    func getData(completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            var request = try auth("/list")
            request.httpMethod = HTTPMethod.get.rawValue
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async { completion(.failure(ApiErrors.invalidData)) }
                    return
                }
                
                DispatchQueue.main.async { completion(.success(data)) }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

    func postData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            var request = try auth("/list")
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                DispatchQueue.main.async { completion(.success(())) }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

    func putData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            var request = try auth("/list")
            request.httpMethod = HTTPMethod.put.rawValue
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                DispatchQueue.main.async { completion(.success(())) }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

    func patchData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            var request = try auth("/list")
            request.httpMethod = HTTPMethod.patch.rawValue
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                DispatchQueue.main.async { completion(.success(())) }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

    func deleteData(data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            var request = try auth("/list")
            request.httpMethod = HTTPMethod.delete.rawValue
            request.httpBody = data
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                DispatchQueue.main.async { completion(.success(())) }
            }.resume()
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
}
