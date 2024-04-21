import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    let quotes: Quotes
    let text: String
    
    init(quotes: Quotes) {
        self.text = [quotes.ltr, quotes.name].joined(separator: " | ")
        self.quotes = quotes
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
