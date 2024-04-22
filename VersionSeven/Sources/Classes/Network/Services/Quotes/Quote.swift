import Foundation

struct Quote: Codable, Hashable {
    
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
}
