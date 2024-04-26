import Foundation

final class StocksService {
    
    private enum Constants {
        static let source = "https://tradernet.com/api/"
    }
    
    private let httpClient = HTTPClient()
    
    func fetch(query: Query<StocksParams>, completion: ((Result<[Stock], Error>) -> ())?) {
        httpClient.send(source: Constants.source, query: query) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(StocksResponse.self, from: data)
                    let stocks = response.tickers.map { Stock(ticker: $0) }
                    completion?(.success(stocks))
                } catch {
                    completion?(.failure(error))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
