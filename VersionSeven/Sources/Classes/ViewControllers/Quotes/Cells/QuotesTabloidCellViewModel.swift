import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    let quotes: Quotes
    
    init(quotes: Quotes) {
        self.quotes = quotes
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
