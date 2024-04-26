import Foundation

protocol QuotesServiceDelegate: AnyObject {
    func didReceive(quotes: [Quote])
}

final class QuotesService {
    
    private lazy var webSocketClient: WebSocketClient? = {
        let client = WebSocketClient(url: URL(string: "wss://wss.tradernet.com"))
        client?.delegate = self
        return client
    }()
    
    private let factory = QuotesFactory()
    private var tickers: [String] = []
    
    private var isConnected: Bool {
        return webSocketClient?.isConnected ?? false
    }
    
    weak var delegate: QuotesServiceDelegate?
    
    func send(tickers: [String]) {
        self.tickers = tickers
        factory.removeAll()
        if isConnected {
            let tickers = tickers.map({ "\"" + $0 + "\"" }).joined(separator: ",")
            let request = "[\"quotes\", [\(tickers)]]"
            guard let data = request.data(using: .utf8) else { return }
            webSocketClient?.send(data: data)
        } else {
            webSocketClient?.connect()
        }
    }
}

extension QuotesService: WebSocketClientDelegate {
    
    func didReceive(data: Data, webSocketClient: WebSocketClient) {
        let quotes = factory.quotes(data: data)
        delegate?.didReceive(quotes: Array(quotes))
    }
    
    func didConnected(webSocketClient: WebSocketClient) {
        send(tickers: tickers)
    }
}
