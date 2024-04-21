import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel, Hashable {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    let quote: Quote
    let text: String
    
    init(quote: Quote) {
        self.text = [quote.ltr, quote.name].joined(separator: " | ")
        self.quote = quote
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
    
    static func == (lhs: QuotesTabloidCellViewModel, rhs: QuotesTabloidCellViewModel) -> Bool {
        return lhs.quote == rhs.quote
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote)
    }
}
