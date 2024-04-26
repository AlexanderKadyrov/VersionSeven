import TabloidView
import Foundation

final class QuoteTabloidCellViewModel: TabloidCellViewModel {
    
    enum Constants {
        static let path = "https://tradernet.com/logos/get-logo-by-ticker?ticker="
        static let cellIdentifier = "QuoteTabloidCellView"
    }
    
    override var differenceIdentifier: String {
        return quote.c
    }
    
    let logoImageViewModel: ImageViewModel?
    let quote: Quote
    let text: String
    
    init(quote: Quote) {
        self.logoImageViewModel = ImageViewModel(url: Self.logoUrl(c: quote.c))
        self.text = [quote.ltr, quote.name]
            .compactMap { $0 }
            .joined(separator: " | ")
        self.quote = quote
        super.init(cellIdentifier: Constants.cellIdentifier)
    }
    
    override func isContentEqual(to source: TabloidCellViewModel) -> Bool {
        guard let source = source as? Self else { return false }
        return source.quote == quote
    }
    
    private static func logoUrl(c: String) -> URL? {
        let c = c.lowercased()
        return URL(string: "\(Constants.path)\(c)")
    }
}
