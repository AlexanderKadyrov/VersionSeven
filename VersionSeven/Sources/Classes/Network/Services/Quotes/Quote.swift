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
    
    /// Тикер
    let c: String
    
    /// Изменение в процентах относительно цены закрытия предыдущей торговой сессии
    let pcp: Float
    
    /// Биржа последней сделки
    let ltr: String?
    
    /// Название бумаги
    let name: String?
    
    /// Цена последней сделки
    var ltp: LTP
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Float
    
    /// Минимальный шаг цены
    let minStep: Float?
    
    func merged(with newQuote: Quote) throws -> Quote {
        let mergedQuote = Quote(
            c: newQuote.c,
            pcp: newQuote.pcp,
            ltr: ltr,
            name: name,
            ltp: newQuote.ltp,
            chg: newQuote.chg,
            minStep: minStep
        )
        return mergedQuote
    }
}
