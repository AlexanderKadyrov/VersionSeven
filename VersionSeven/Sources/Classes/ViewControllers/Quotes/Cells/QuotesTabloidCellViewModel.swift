import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    let quote: Quote
    let text: String
    
    init(quote: Quote) {
        self.text = [quote.ltr, quote.name]
            .compactMap { $0 }
            .joined(separator: " | ")
        self.quote = quote
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
