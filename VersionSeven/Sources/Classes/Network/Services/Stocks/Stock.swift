import Foundation

struct Stock: Hashable {
    
    let ticker: String
    let selected: Bool
    
    init(ticker: String, selected: Bool = false) {
        self.ticker = ticker
        self.selected = selected
    }
}
