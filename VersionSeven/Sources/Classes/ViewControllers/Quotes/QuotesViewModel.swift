import Foundation

final class QuotesViewModel {
    
    private lazy var quotesService: QuotesService = {
        let service = QuotesService()
        service.delegate = self
        return service
    }()
    
    func viewDidLoad() {
        quotesService.subscribe()
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quotes]) {
        
    }
}
