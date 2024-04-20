import Foundation
import Starscream

final class WebSocketClient {
    
    func subscribe() {
        var request = URLRequest(url: URL(string: "wss://wss.tradernet.com")!)
        request.timeoutInterval = 5
        let socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
}

extension WebSocketClient: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let value):
            break
        case .disconnected(let value, let code):
            break
        case .text(let value):
            break
        case .binary(let value):
            break
        case .pong(let value):
            break
        case .ping(let value):
            break
        case .error(let value):
            break
        case .viabilityChanged(let value):
            break
        case .reconnectSuggested(let value):
            break
        case .cancelled:
            break
        case .peerClosed:
            break
        }
    }
}
