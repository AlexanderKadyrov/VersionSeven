import Foundation

final class HTTPClient {
    
    private enum Errors: Error {
        case undefined
    }
    
    func send(request: URLRequest, completion: ((Result<Data, Error>) -> ())?) {
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                completion?(.success(data))
            } else if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.failure(Errors.undefined))
            }
        }
        task.resume()
    }
}
