import Foundation

struct Quotes: Codable {
    
    /// Тикер
    let c: String
    
    /// Изменение в процентах относительно цены закрытия предыдущей торговой сессии
    let pcp: Float
    
    /// Биржа последней сделки
    let ltr: String
    
    /// Название бумаги
    let name: String
    
    /// Цена последней сделки
    let ltp: Float
    
    /// Изменение цены последней сделки в пунктах относительно цены закрытия предыдущей торговой сессии
    let chg: Float
}
