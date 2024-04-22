import TabloidView
import Foundation

final class QuotesViewModel {
    
    private let identifiers = [
        "SP500.IDX",
        "AAPL.US",
        "RSTI",
        "GAZP",
        "MRKZ",
        "RUAL",
        "HYDR",
        "MRKS",
        "SBER",
        "FEES",
        "TGKA",
        "VTBR",
        "ANH.US",
        "VICL.US",
        "BURG.US",
        "NBL.US",
        "YETI.US",
        "WSFS.US",
        "NIO.US",
        "DXC.US",
        "MIC.US",
        "HSBC.US",
        "EXPN.EU",
        "GSK.EU",
        "SHP.EU",
        "MAN.EU",
        "DB1.EU",
        "MUV2.EU",
        "TATE.EU",
        "KGF.EU",
        "MGGT.EU",
        "SGGD.EU"
    ]
    
    private lazy var quotesService: QuotesService = {
        let service = QuotesService(identifiers: identifiers)
        service.delegate = self
        return service
    }()
    
    let tabloidViewModel = TabloidViewModel()
    
    func viewDidLoad() {
        quotesService.subscribe()
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quote]) {
        let cellViewModels = quotes.map { QuotesTabloidCellViewModel(quote: $0) }
        let new = Set(cellViewModels)
        
        let oldSections = tabloidViewModel.sections
            .flatMap { $0 }
            .compactMap { $0 as? QuotesTabloidCellViewModel }
        
        let old = Set(oldSections)
        let newSections = Array(new.union(old))
        let sorted = newSections.sorted(like: identifiers, keyPath: \.quote.c)
        
        tabloidViewModel.sections = [sorted]
    }
}
