import Foundation
import Starscream

protocol WebSocketClientDelegate: AnyObject {
    func didReceive(error: Error, webSocketClient: WebSocketClient)
    func didReceive(data: Data, webSocketClient: WebSocketClient)
    func didDisconnected(webSocketClient: WebSocketClient)
    func didConnected(webSocketClient: WebSocketClient)
}

extension WebSocketClientDelegate {
    func didReceive(error: Error, webSocketClient: WebSocketClient) {}
    func didDisconnected(webSocketClient: WebSocketClient) {}
}

final class WebSocketClient {
    
    private let webSocket: WebSocket
    
    weak var delegate: WebSocketClientDelegate?
    
    init?(url: URL?) {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        webSocket = WebSocket(request: request)
        webSocket.delegate = self
    }
    
    func disconnect() {
        webSocket.disconnect()
    }
    
    func connect() {
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
            delegate?.didConnected(webSocketClient: self)
        case .disconnected:
            delegate?.didDisconnected(webSocketClient: self)
        case .text(let text):
            guard let data = text.data(using: .utf8) else { return }
            delegate?.didReceive(data: data, webSocketClient: self)
        case .binary(let data):
            delegate?.didReceive(data: data, webSocketClient: self)
        case .error(let error):
            guard let error = error else { return }
            delegate?.didReceive(error: error, webSocketClient: self)
        default:
            break
        }
    }
}
