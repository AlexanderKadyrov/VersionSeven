import Foundation
import SwiftyJSON

protocol QuotesServiceDelegate: AnyObject {
    func didReceive(quotes: [Quote])
}

final class QuotesService {
    
    private lazy var webSocketClient: WebSocketClient? = {
        let client = WebSocketClient(url: URL(string: "wss://wss.tradernet.com"))
        client?.delegate = self
        return client
    }()
    
    private var quotes = Set<Quote>()
    private let tickers: [String]
    
    weak var delegate: QuotesServiceDelegate?
    
    init(tickers: [String]) {
        self.tickers = tickers
    }
    
    func unsubscribe() {
        webSocketClient?.disconnect()
    }
    
    func subscribe() {
        webSocketClient?.connect()
    }
}

extension QuotesService: WebSocketClientDelegate {
    
    func didReceive(data: Data, webSocketClient: WebSocketClient) {
        do {
            let list = try JSONDecoder().decode([List<Quote>].self, from: data)
            let result = list.compactMap { result in
                if case let .object(value) = result {
                    return value
                }
                return nil
            }
            
            for newQuote in result {
                if let oldQuote = quotes.first(where: { $0.c == newQuote.c }) {
                    let mergedQuote = oldQuote.merged(with: newQuote)
                    quotes.remove(oldQuote)
                    quotes.insert(mergedQuote)
                } else {
                    quotes.insert(newQuote)
                }
            }
            
            delegate?.didReceive(quotes: Array(quotes))
        } catch {
            
        }
    }
    
    func didConnected(webSocketClient: WebSocketClient) {
        let tickers = tickers.map({ "\"" + $0 + "\"" }).joined(separator: ",")
        let request = "[\"quotes\", [\(tickers)]]"
        guard let data = request.data(using: .utf8) else { return }
        webSocketClient.send(data: data)
    }
}
