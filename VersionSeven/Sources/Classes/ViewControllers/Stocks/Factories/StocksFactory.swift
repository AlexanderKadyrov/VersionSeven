import Foundation

final class StocksFactory {
    static func stocks() -> [Stock] {
        guard
            let path = Bundle.main.path(forResource: "stock", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let elements = try? JSONDecoder().decode([String].self, from: data)
        else {
            return []
        }
        return elements.map { Stock(ticker: $0, selected: true) }
    }
}
