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
        let oldQuote = self
        let oldData = try JSONEncoder().encode(oldQuote)
        let oldObject = try JSON(data: oldData)
        
        let newData = try JSONEncoder().encode(newQuote)
        let newObject = try JSON(data: newData)
        
        let merged = try oldObject.merged(with: newObject)
        let mergedData = try merged.rawData()
        var mergedQuote = try JSONDecoder().decode(Quote.self, from: mergedData)
        
        if mergedQuote.ltp > oldQuote.ltp {
            mergedQuote.ltp = .up(mergedQuote.ltp.rawValue)
        } else if mergedQuote.ltp < oldQuote.ltp {
            mergedQuote.ltp = .down(mergedQuote.ltp.rawValue)
        } else {
            mergedQuote.ltp = .equal(mergedQuote.ltp.rawValue)
        }
        
        return mergedQuote
    }
}
