import Foundation

enum NetErrors: Error {
    case NoNameError
}

extension URLSession {
    func dataTask(for request: URLRequest) async throws -> (Data, URLResponse) {
//        let data: (Data, URLResponse) =
        return try await withCheckedThrowingContinuation({ continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: NetErrors.NoNameError)
                }
            }
            task.resume()
            
//            task.cancel()
        })

    }
}


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
