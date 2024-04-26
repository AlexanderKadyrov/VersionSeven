import Foundation

struct StocksParams: Codable {
    let type: String
    let exchange: String
    let gainers: Int
    let limit: Int
}
