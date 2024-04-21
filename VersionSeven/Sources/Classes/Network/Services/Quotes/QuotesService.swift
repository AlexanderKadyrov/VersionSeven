import Foundation
import SwiftyJSON

protocol QuotesServiceDelegate: AnyObject {
    func didReceive(quotes: [Quotes])
}

final class QuotesService {
    
    private var oldValue = JSON([])
    private lazy var client: WebSocketClient? = {
        let client = WebSocketClient(url: URL(string: "wss://wss.tradernet.com"))
        client?.delegate = self
        return client
    }()
    
    weak var delegate: QuotesServiceDelegate?
    
    func unsubscribe() {
        client?.disconnect()
    }
    
    func subscribe() {
        client?.connect()
    }
}

extension QuotesService: WebSocketClientDelegate {
    
    func didReceive(error: Error, webSocketClient: WebSocketClient) {
        
    }
    
    func didReceive(data: Data, webSocketClient: WebSocketClient) {
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
    
    func didDisconnected(webSocketClient: WebSocketClient) {
        
    }
    
    func didConnected(webSocketClient: WebSocketClient) {
        let request = "[\"quotes\", [\"GAZP\",\"AAPL.US\"]]"
        guard let data = request.data(using: .utf8) else { return }
        webSocketClient.send(data: data)
    }
}
