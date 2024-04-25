import TabloidView
import Foundation

final class QuotesViewModel {
    
    private(set) var stocks = Set<Stock>(StocksFactory.stocks())
    
    private lazy var quotesService: QuotesService = {
        let service = QuotesService(tickers: tickers())
        service.delegate = self
        return service
    }()
    
    let tabloidViewModel = TabloidViewModel()
    
    func viewDidLoad() {
        quotesService.subscribe()
    }
    
    private func tickers() -> [String] {
        return stocks
            .filter { $0.selected }
            .map { $0.ticker }
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quote]) {
        let cellViewModels = quotes.map { QuotesTabloidCellViewModel(quote: $0) }
        let sorted = cellViewModels.sorted(by: { $0.quote.c < $1.quote.c })
        let sections: [Section<TabloidCellViewModel>] = [
            Section(index: .zero, elements: sorted)
        ]
        tabloidViewModel.reload(
            sections: sections,
            animation: .none
        )
    }
}

extension QuotesViewModel: StocksViewModelDelegate {
    func set(stocks: Set<Stock>) {
        self.stocks = stocks
        quotesService.send(tickers: tickers())
    }
}
