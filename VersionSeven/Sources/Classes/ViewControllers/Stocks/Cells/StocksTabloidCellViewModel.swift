import TabloidView
import Foundation

final class StocksTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let cellIdentifier = "StocksTabloidCellView"
    }
    
    let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
}
