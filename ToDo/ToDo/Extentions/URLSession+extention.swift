import Foundation

enum NetErrors: Error {
    case NoNameError
}

extension URLSession {
    func dataTask(for request: URLRequest) async throws -> (Data, URLResponse) {
//        let data: (Data, URLResponse) =
        return try await withCheckedThrowingContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: NetErrors.NoNameError)
                }
            }
            if Task.isCancelled {
                task.cancel()
            } else {
                task.resume()
            }
        }

    }
}


//extension URLSession {
//    func dataTask(for urlRequest: URLRequest) async throws -> (Data, URL) {
//        var currentDataTask: URLSessionDataTask?
//        return try await withTaskCancellationHandler{
//            return try await withCheckedThrowingContinuation { continuation in
//                currentDataTask = URLSession. shared.dataTask(with: urlRequest) { data, responce, error in
//                    if let error = error {
//                        continuation.resume (throwing: error)
//                    } else if let data = data, let responce = responce {
//                        continuation.resume (returning: (data, responce))
//                    } else {
//                        continuation.resume (throwing: URLError.invalidData)
//                    }
//            }
//        }
//    }
//    var currentDataTask: URLSessionDataTask?
//    (Data, URLResponse) {
//    return try await withTaskCancellationHandler{
//    return try await withCheckedThrowingContinuation { continuation in
//    currentDataTask = URLSession. shared.dataTask(with: urlRequest) { data,
//    responce, error in
//    if let error = error {
//    continuation. resume (throwing: error)
//    } else if let data = data, let responce = responce {
//    continuation. resume (returning: (data, responce))
//    } else
//    continuation. resume (throwing: URLError.invalidData)
//    currentDataTask?.resume()
//    } onCancel: { [weak currentDataTask] in
//    currentDataTask?.cancel()
//}


//let data: (Data, URLResponse) = try await withCheckedThrowingContinuation({ continuation in
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            continuation.resume(throwing: error)
//        } else if let data = data, let response = response {
//            continuation.resume(returning: (data, response))
//        } else {
//            continuation.resume(throwing: NetErrors.NoNameError)
//        }
//    }
//    task.resume()
//})
