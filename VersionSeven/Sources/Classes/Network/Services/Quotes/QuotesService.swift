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
            let newValue = try JSON(data: data)
            if let q = newValue[0].string, q == "q" {
                let newObject = newValue[1]
                let newData = try newObject.rawData()
                let newQuote = try JSONDecoder().decode(Quote.self, from: newData)
                if let oldQuote = quotes.first(where: { $0.c == newQuote.c }) {
                    let oldData = try JSONEncoder().encode(oldQuote)
                    let oldObject = try JSON(data: oldData)
                    let merged = try oldObject.merged(with: newObject)
                    let mergedData = try merged.rawData()
                    let mergedQuote = try JSONDecoder().decode(Quote.self, from: mergedData)
                    quotes = Set([mergedQuote]).union(quotes)
                } else {
                    quotes = Set([newQuote]).union(quotes)
                }
                delegate?.didReceive(quotes: Array(quotes))
            }
        } catch {
            
        }
    }
    
    func didConnected(webSocketClient: WebSocketClient) {
        let request = "[\"quotes\", [\(identifiers.map({ "\"" + $0 + "\"" }).joined(separator: ","))]]"
        guard let data = request.data(using: .utf8) else { return }
        webSocketClient.send(data: data)
    }
}
