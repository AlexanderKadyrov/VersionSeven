import TabloidView
import Foundation
import UIKit

protocol StocksViewModelDelegate: AnyObject {
    func set(stocks: Set<Stock>)
}

final class StocksViewModel {
    
    private let stocksService = StocksService()
    private var stocks: Set<Stock>
    
    weak var delegate: StocksViewModelDelegate?
    let tabloidViewModel = TabloidViewModel()
    
    var hasEnabledOneStock: Bool {
        return stocks.contains { $0.selected }
    }
    
    init(stocks: Set<Stock>) {
        self.stocks = stocks
    }
    
    func viewDidLoad() {
        append(elements: [])
        let params = StocksParams(type: "stocks", exchange: "russia", gainers: .zero, limit: 30)
        let query = Query(cmd: "getTopSecurities", params: params)
        stocksService.fetch(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let elements):
                DispatchQueue.main.async {
                    self.append(elements: elements)
                }
            case .failure:
                self.append(elements: [])
            }
        }
    }
    
    func actionUndo() {
        let items = stocks.map { Stock(ticker: $0.ticker, selected: false) }
        stocks = Set(items)
        reload(animation: .none)
    }
    
    func actionRedo() {
        let items = stocks.map { Stock(ticker: $0.ticker, selected: true) }
        stocks = Set(items)
        reload(animation: .none)
    }
    
    func actionDone() {
        delegate?.set(stocks: stocks)
    }
    
    private func append(elements: [Stock]) {
        for newValue in elements {
            guard !stocks.contains(where: { $0.ticker == newValue.ticker }) else {
                continue
            }
            stocks.insert(newValue)
        }
        reload(animation: .fade)
    }
    
    private func reload(animation: UITableView.RowAnimation) {
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
            animation: animation
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
        reload(animation: .none)
    }
}
