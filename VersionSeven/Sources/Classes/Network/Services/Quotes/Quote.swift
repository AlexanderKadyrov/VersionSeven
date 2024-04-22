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
    let ltp: LTP
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Float
    
    /// Минимальный шаг цены
    let minStep: Float?
    
    func merged(with newQuote: Quote) throws -> Quote {
        let oldData = try JSONEncoder().encode(self)
        let oldObject = try JSON(data: oldData)
        
        let newData = try JSONEncoder().encode(newQuote)
        let newObject = try JSON(data: newData)
        
        let merged = try oldObject.merged(with: newObject)
        let mergedData = try merged.rawData()
        let mergedQuote = try JSONDecoder().decode(Quote.self, from: mergedData)
        
        return mergedQuote
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.c == rhs.c
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(c)
    }
}
