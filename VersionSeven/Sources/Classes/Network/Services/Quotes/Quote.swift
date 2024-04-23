import Foundation
import SwiftyJSON

struct Quote: Codable, Hashable {
    
    enum Errors: Error {
        case emptyQuote
    }
    
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
    let c: String?
    
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
    
    func merged(with newQuote: Quote) throws -> Quote {
        guard
            let c = newQuote.c,
            let pcp = newQuote.pcp,
            let ltp = newQuote.ltp,
            let chg = newQuote.chg
        else {
            throw Errors.emptyQuote
        }
        
        let mergedQuote = Quote(
            c: c,
            pcp: pcp,
            ltr: ltr,
            name: name,
            ltp: ltp,
            chg: chg,
            minStep: minStep
        )
        
        return mergedQuote
    }
}
