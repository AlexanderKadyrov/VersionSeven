import TabloidView
import Foundation

final class StockTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "StockTabloidCellView"
    }
    
    override var differenceIdentifier: String {
        return stock.ticker
    }
    
    let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
    
    override func isContentEqual(to source: TabloidCellViewModel) -> Bool {
        guard let source = source as? Self else { return false }
        return source.stock == stock
    }
}
