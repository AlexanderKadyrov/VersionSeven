import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel, Hashable {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    private(set) var ltp: LTP
    
    let quote: Quote
    let text: String
    
    init(quote: Quote) {
        self.text = [quote.ltr, quote.name].joined(separator: " | ")
        self.ltp = .equal(quote.ltp)
        self.quote = quote
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
    
    static func == (lhs: QuotesTabloidCellViewModel, rhs: QuotesTabloidCellViewModel) -> Bool {
        if lhs.quote.c == rhs.quote.c {
            if lhs.quote.ltp > rhs.quote.ltp {
                lhs.ltp = .up(lhs.quote.ltp)
                rhs.ltp = .down(rhs.quote.ltp)
            } else if lhs.quote.ltp < rhs.quote.ltp {
                lhs.ltp = .down(lhs.quote.ltp)
                rhs.ltp = .up(rhs.quote.ltp)
            } else {
                lhs.ltp = .equal(lhs.quote.ltp)
                rhs.ltp = .equal(rhs.quote.ltp)
            }
            return true
        }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote.c)
    }
}
