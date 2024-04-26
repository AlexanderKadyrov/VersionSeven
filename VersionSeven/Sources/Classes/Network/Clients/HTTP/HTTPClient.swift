import Foundation

final class HTTPClient {
    
    private enum Errors: Error {
        case undefined
        case urlEmpty
    }
    
    func send<P: Codable>(source: String, query: Query<P>, completion: ((Result<Data, Error>) -> ())?) {
        guard var components = URLComponents(string: source) else {
            completion?(.failure(Errors.urlEmpty))
            return
        }
        do {
            let data = try JSONEncoder().encode(query)
            let q = String(decoding: data, as: UTF8.self)
            components.queryItems = [URLQueryItem(name: "q", value: q)]
            guard let url = components.url else {
                completion?(.failure(Errors.urlEmpty))
                return
            }
            let request = URLRequest(url: url)
            send(request: request, completion: completion)
        } catch(let error) {
            completion?(.failure(error))
        }
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
