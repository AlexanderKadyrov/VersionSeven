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
    
    private let identifiers: [String]
    private var quotes = Set<Quote>()
    
    weak var delegate: QuotesServiceDelegate?
    
    init(identifiers: [String]) {
        self.identifiers = identifiers
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
                    let mergedQuote = try oldQuote.merged(with: newQuote)
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
        let request = "[\"quotes\", [\(identifiers.map({ "\"" + $0 + "\"" }).joined(separator: ","))]]"
        guard let data = request.data(using: .utf8) else { return }
        webSocketClient.send(data: data)
    }
}
