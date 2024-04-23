import Foundation
import SwiftyJSON

struct Quote: Codable, Hashable {
    
    enum CodingKeys : String, CodingKey {
        case c
        case pcp
        case ltr
        case name
        case ltp
        case chg
        case minStep = "min_step"
    }
    
    var isEmpty: Bool {
        let sum = [pcp, ltp, chg]
            .compactMap { $0 }
            .reduce(0, +)
        return sum == .zero
    }
    
    /// Тикер
    let c: String
    
    /// Изменение в процентах относительно цены закрытия предыдущей торговой сессии
    let pcp: Float?
    
    /// Биржа последней сделки
    let ltr: String?
    
    /// Название бумаги
    let name: String?
    
    /// Цена последней сделки
    let ltp: Float?
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Float?
    
    /// Минимальный шаг цены
    let minStep: Float?
    
    func merged(with newQuote: Quote) -> Quote? {
        guard !newQuote.isEmpty else { return nil }
        return Quote(
            c: c,
            pcp: newQuote.pcp,
            ltr: ltr,
            name: name,
            ltp: newQuote.ltp,
            chg: newQuote.chg,
            minStep: minStep
        )
    }
}
