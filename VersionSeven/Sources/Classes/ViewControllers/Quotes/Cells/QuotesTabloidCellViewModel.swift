import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    override var differenceIdentifier: String {
        return quote.c
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
    
    override func isContentEqual(to source: TabloidCellViewModel) -> Bool {
        guard let source = source as? QuotesTabloidCellViewModel else { return false }
        return source.quote == quote
    }
}
