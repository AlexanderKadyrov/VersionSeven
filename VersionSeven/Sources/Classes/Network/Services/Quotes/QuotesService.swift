import Foundation
import SwiftyJSON

protocol QuotesServiceDelegate: AnyObject {
    func didReceive(quotes: [Quotes])
}

final class QuotesService {
    
    private weak var delegate: QuotesServiceDelegate?
    
    private let client = WebSocketClient(url: URL(string: "wss://wss.tradernet.com"))
    private var oldValue = JSON([])
    
    init() {
        client?.set(delegate: self)
    }
    
    func set(delegate: QuotesServiceDelegate) {
        self.delegate = delegate
    }
    
    func unsubscribe() {
        client?.disconnect()
    }
    
    func subscribe() {
        client?.connect()
    }
}

extension QuotesService: WebSocketClientDelegate {
    
    func didReceive(error: Error, client: WebSocketClient) {
        
    }
    
    func didReceive(data: Data, client: WebSocketClient) {
        do {
            let newValue = try JSON(data: data)
            if let q = newValue[0].string, q == "q" {
                let object = newValue[1]
                if var old = oldValue.enumerated().first(where: { $0.element.1["c"].stringValue == object["c"].stringValue }) {
                    try old.element.1.merge(with: object)
                    oldValue[old.offset] = old.element.1
                } else {
                    try oldValue.merge(with: [object])
                }
                let rawData = try oldValue.rawData()
                let quotes = try JSONDecoder().decode([Quotes].self, from: rawData)
                delegate?.didReceive(quotes: quotes)
            }
        } catch {
            
        }
    }
    
    func didDisconnected(client: WebSocketClient) {
        
    }
    
    func didConnected(client: WebSocketClient) {
        let request = "[\"quotes\", [\"GAZP\",\"AAPL.US\"]]"
        guard let data = request.data(using: .utf8) else { return }
        client.send(data: data)
    }
}
