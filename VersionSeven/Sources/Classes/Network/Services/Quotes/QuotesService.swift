import Foundation
import SwiftyJSON

protocol QuotesServiceDelegate: AnyObject {
    func didReceive(quotes: [Quote])
}

final class QuotesService {
    
    private var oldValue = JSON([])
    private lazy var webSocketClient: WebSocketClient? = {
        let client = WebSocketClient(url: URL(string: "wss://wss.tradernet.com"))
        client?.delegate = self
        return client
    }()
    
    weak var delegate: QuotesServiceDelegate?
    
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
                let object = newValue[1]
                if var old = oldValue.enumerated().first(where: { $0.element.1["c"].stringValue == object["c"].stringValue }) {
                    try old.element.1.merge(with: object)
                    oldValue[old.offset] = old.element.1
                } else {
                    try oldValue.merge(with: [object])
                }
                let rawData = try oldValue.rawData()
                let quotes = try JSONDecoder().decode([Quote].self, from: rawData)
                delegate?.didReceive(quotes: quotes)
            }
        } catch {
            
        }
    }
    
    func didConnected(webSocketClient: WebSocketClient) {
        let documents = [
            "SP500.IDX",
            "AAPL.US",
            "RSTI",
            "GAZP",
            "MRKZ",
            "RUAL",
            "HYDR",
            "MRKS",
            "SBER",
            "FEES",
            "TGKA",
            "VTBR",
            "ANH.US",
            "VICL.US",
            "BURG.US",
            "NBL.US",
            "YETI.US",
            "WSFS.US",
            "NIO.US",
            "DXC.US",
            "MIC.US",
            "HSBC.US",
            "EXPN.EU",
            "GSK.EU",
            "SHP.EU",
            "MAN.EU",
            "DB1.EU",
            "MUV2.EU",
            "TATE.EU",
            "KGF.EU",
            "MGGT.EU",
            "SGGD.EU"
        ]
        let request = "[\"quotes\", [\(documents.map({ "\"" + $0 + "\"" }).joined(separator: ","))]]"
        guard let data = request.data(using: .utf8) else { return }
        webSocketClient.send(data: data)
    }
}
