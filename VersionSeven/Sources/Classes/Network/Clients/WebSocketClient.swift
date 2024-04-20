import Foundation
import Starscream

final class WebSocketClient {
    
    private let socket: WebSocket
    
    init() {
        var request = URLRequest(url: URL(string: "wss://wss.tradernet.com")!)
        request.timeoutInterval = 10
        socket = WebSocket(request: request)
    }
    
    func subscribe() {
        socket.delegate = self
        socket.connect()
    }
}

extension WebSocketClient: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let value):
            do {
                //let json = "{\"quotes\": [\"AAPL.US\"]}"
                //let request = RealtimeQuotesRequest(realtimeQuotes: ["AAPL.US"])
                //let data = try JSONEncoder().encode([request])
                client.write(string: "[\"quotes\", [\"GAZP\",\"AAPL.US\"]]")
            } catch {
                
            }
        case .disconnected(let value, let code):
            break
        case .text(let text):
            do {
                print(text)
                let data = text.data(using: .utf8)!
                let list = try JSONDecoder().decode([List<RealtimeQuotesResponse>].self, from: data)
                list.forEach { result in
                    if case let .object(value) = result {
                        //print(value)
                    }
                }
            } catch {
                //print(error)
            }
        case .binary(let value):
            break
        case .pong(let value):
            print(value)
        case .ping(let value):
            break
        case .error(let value):
            print(value)
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
