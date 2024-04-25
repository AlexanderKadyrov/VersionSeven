import TabloidView
import Foundation

final class StockTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "StockTabloidCellView"
    }
    
    let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
