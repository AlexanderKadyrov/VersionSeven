import Foundation
import Starscream

final class WebSocketClient {
    
    private let socket: WebSocket
    
    init() {
        //wss://a.nel.cloudflare.ru
        //wss://wss.tradernet.ru
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

enum List<O: Codable>: Codable {
    
    case string(String)
    case object(O)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .string(container.decode(String.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .object(container.decode(O.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(Self.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}
