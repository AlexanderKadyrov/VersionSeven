import Foundation
import Starscream

protocol WebSocketClientDelegate: AnyObject {
    func didConnected()
    func didDisconnected()
    func didReceive(data: Data, client: WebSocketClient)
    func didReceive(error: Error)
}

final class WebSocketClient {
    
    private weak var delegate: WebSocketClientDelegate?
    
    private let socket: WebSocket
    
    init?(url: URL?) {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        socket = WebSocket(request: request)
    }
    
    func set(delegate: WebSocketClientDelegate) {
        self.delegate = delegate
    }
    
    func connect() {
        socket.delegate = self
        socket.connect()
    }
}

extension WebSocketClient: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected:
            delegate?.didConnected()
        case .disconnected:
            delegate?.didDisconnected()
        case .text(let text):
            guard let data = text.data(using: .utf8) else { return }
            delegate?.didReceive(data: data, client: self)
        case .binary(let data):
            delegate?.didReceive(data: data, client: self)
        case .error(let error):
            guard let error = error else { return }
            delegate?.didReceive(error: error)
        default:
            break
        }
    }
}
