import Foundation

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
    let pcp: Double
    
    /// Биржа последней сделки
    let ltr: String
    
    /// Название бумаги
    let name: String
    
    /// Цена последней сделки
    let ltp: Double
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Double
    
    let minStep: Double
}
