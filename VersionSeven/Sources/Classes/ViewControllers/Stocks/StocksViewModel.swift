import TabloidView
import Foundation

final class StocksViewModel {
    
    private var stocks: Set<Stock>
    
    let tabloidViewModel = TabloidViewModel()
    
    init(stocks: Set<Stock>) {
        self.stocks = stocks
    }
    
    func viewDidLoad() {
        reloadSections()
    }
    
    private func reloadSections() {
        var elements: [StockTabloidCellViewModel] = []
        for stock in stocks {
            let cellViewModel = StockTabloidCellViewModel(stock: stock)
            cellViewModel.delegate = self
            elements.append(cellViewModel)
        }
        let sorted = elements.sorted(by: { $0.stock.ticker < $1.stock.ticker })
        let sections: [Section<TabloidCellViewModel>] = [
            Section(index: .zero, elements: sorted)
        ]
        tabloidViewModel.reload(
            sections: sections,
            animation: .none
        )
    }
}

extension StocksViewModel: TabloidCellViewModelDelegate {
    func didSelect(cellViewModel: TabloidCellViewModel) {
        guard let cellViewModel = cellViewModel as? StockTabloidCellViewModel else { return }
        let oldStock = cellViewModel.stock
        let newStock = Stock(ticker: oldStock.ticker, selected: !oldStock.selected)
        stocks.remove(oldStock)
        stocks.insert(newStock)
        reloadSections()
    }
}
