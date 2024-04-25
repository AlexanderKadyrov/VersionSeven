import TabloidView
import Foundation

final class StocksViewModel {
    
    let tabloidViewModel = TabloidViewModel()
    let stocks: [Stock]
    
    init(stocks: [Stock]) {
        self.stocks = stocks
    }
    
    func viewDidLoad() {
        let elements = stocks.map { StockTabloidCellViewModel(stock: $0) }
        let sections: [Section<TabloidCellViewModel>] = [
            Section(index: .zero, elements: elements)
        ]
        tabloidViewModel.reload(
            sections: sections,
            animation: .none
        )
    }
}
