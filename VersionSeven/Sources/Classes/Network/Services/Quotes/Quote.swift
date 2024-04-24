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
    let pcp: Double?
    
    /// Биржа последней сделки
    let ltr: String?
    
    /// Название бумаги
    let name: String?
    
    /// Цена последней сделки
    let ltp: LTP?
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Double?
    
    /// Минимальный шаг цены
    let minStep: Double?
    
    func merged(with newQuote: Quote) -> Quote {
        return Quote(
            c: c,
            pcp: newQuote.pcp ?? pcp,
            ltr: ltr,
            name: name,
            ltp: ltpCompare(newValue: newQuote.ltp, oldValue: ltp),
            chg: newQuote.chg ?? chg,
            minStep: minStep
        )
    }
    
    private func ltpCompare(newValue: LTP?, oldValue: LTP?) -> LTP? {
        if let newValue = newValue, let oldValue = oldValue {
            if newValue > oldValue {
                return .up(newValue.rawValue)
            } else if newValue < oldValue {
                return .down(newValue.rawValue)
            } else {
                return .equal(newValue.rawValue)
            }
        } else if let merged = newValue ?? oldValue {
            return .equal(merged.rawValue)
        }
        return nil
    }
}
