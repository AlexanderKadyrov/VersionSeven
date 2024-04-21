import Foundation

final class QuotesViewModel {
    
    private let service = QuotesService()
    
    init() {
        service.set(delegate: self)
    }
    
    func viewDidLoad() {
        service.subscribe()
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quotes]) {
        
    }
}
