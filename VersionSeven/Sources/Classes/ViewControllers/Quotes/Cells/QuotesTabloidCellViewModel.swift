import TabloidView
import Foundation

final class QuotesTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "QuotesTabloidCellView"
    }
    
    let quoteContainer: QuoteContainer
    
    init(quoteContainer: QuoteContainer) {
        self.quoteContainer = quoteContainer
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
