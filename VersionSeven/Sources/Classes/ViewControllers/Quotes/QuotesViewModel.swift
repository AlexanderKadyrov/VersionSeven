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
    
    func actionEdit() {
        
    }
}

extension QuotesViewModel: QuotesServiceDelegate {
    func didReceive(quotes: [Quote]) {
        let cellViewModels = quotes.map { QuotesTabloidCellViewModel(quote: $0) }
        let sorted = cellViewModels.sorted(like: identifiers, keyPath: \.quote.c)
        let sections: [Section<TabloidCellViewModel>] = [
            Section(index: .zero, elements: sorted)
        ]
        tabloidViewModel.reload(
            sections: sections,
            animation: .none
        )
    }
}
