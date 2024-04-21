import Foundation
import Starscream

protocol WebSocketClientDelegate: AnyObject {
    func didReceive(error: Error, client: WebSocketClient)
    func didReceive(data: Data, client: WebSocketClient)
    func didDisconnected(client: WebSocketClient)
    func didConnected(client: WebSocketClient)
}

final class WebSocketClient {
    
    private let webSocket: WebSocket
    
    weak var delegate: WebSocketClientDelegate?
    
    init?(url: URL?) {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        webSocket = WebSocket(request: request)
    }
    
    func disconnect() {
        webSocket.disconnect()
    }
    
    func connect() {
        webSocket.delegate = self
        webSocket.connect()
    }
    
    func send(data: Data) {
        webSocket.write(data: data)
    }
}

extension WebSocketClient: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected:
            delegate?.didConnected(client: self)
        case .disconnected:
            delegate?.didDisconnected(client: self)
        case .text(let text):
            guard let data = text.data(using: .utf8) else { return }
            delegate?.didReceive(data: data, client: self)
        case .binary(let data):
            delegate?.didReceive(data: data, client: self)
        case .error(let error):
            guard let error = error else { return }
            delegate?.didReceive(error: error, client: self)
        default:
            break
        }
    }
}
