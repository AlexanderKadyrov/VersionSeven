import Foundation

struct QuoteContainer {
    
    let quote: Quote
    let text: String
    let ltp: LTP
    
    init(newQuote: Quote, oldQuote: Quote?) {
        quote = newQuote
        
        text = [newQuote.ltr, newQuote.name]
            .compactMap { $0 }
            .joined(separator: " | ")
        
        if let oldQuote = oldQuote {
            if newQuote.ltp > oldQuote.ltp {
                ltp = .up(newQuote.ltp)
            } else if newQuote.ltp < oldQuote.ltp {
                ltp = .down(newQuote.ltp)
            } else {
                ltp = .equal(newQuote.ltp)
            }
        } else {
            ltp = .equal(newQuote.ltp)
        }
    }
}
