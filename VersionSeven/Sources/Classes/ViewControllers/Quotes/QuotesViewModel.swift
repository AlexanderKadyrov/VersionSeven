import TabloidView
import Foundation

final class QuotesViewModel {
    
    private lazy var quotesService: QuotesService = {
        let service = QuotesService()
        service.delegate = self
        return service
    }()
    
    let tabloidViewModel = TabloidViewModel()
    
    func viewDidLoad() {
        quotesService.subscribe()
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quotes]) {
        let cellViewModels = quotes.map { QuotesTabloidCellViewModel(quotes: $0) }
        tabloidViewModel.sections = [cellViewModels]
    }
}
