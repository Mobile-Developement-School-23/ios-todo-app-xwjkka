import Foundation

protocol NetworkService {
    func getData(completion: @escaping (Result<Data, Error>) -> Void)
    func postData(data: Data, completion: @escaping (Result<Void, Error>) -> Void)
    func putData(data: Data, completion: @escaping (Result<Void, Error>) -> Void)
    func patchData(data: Data, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteData(data: Data, completion: @escaping (Result<Void, Error>) -> Void)
}
