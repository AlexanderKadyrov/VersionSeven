import TabloidView
import Foundation

final class QuotesViewModel {
    
    private(set) var stocks = Set<Stock>(StocksFactory.stocks())
    
    private lazy var quotesService: QuotesService = {
        let service = QuotesService()
        service.delegate = self
        return service
    }()
    
    let tabloidViewModel = TabloidViewModel()
    
    func viewDidLoad() {
        quotesService.send(tickers: tickers())
    }
    
    private func tickers() -> [String] {
        return stocks
            .filter { $0.selected }
            .map { $0.ticker }
    }
    
    private func reload(quotes: [Quote]) {
        let cellViewModels = quotes.map { QuoteTabloidCellViewModel(quote: $0) }
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

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quote]) {
        reload(quotes: quotes)
    }
}

extension QuotesViewModel: StocksViewModelDelegate {
    func set(stocks: Set<Stock>) {
        guard self.stocks != stocks else {
            return
        }
        self.stocks = stocks
        reload(quotes: [])
        quotesService.send(tickers: tickers())
    }
}
