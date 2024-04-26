import Foundation

final class QuotesFactory {
    
    private var quotes = Set<Quote>()
    
    func quotes(data: Data) -> [Quote] {
        do {
            let list = try JSONDecoder().decode([List<Quote>].self, from: data)
            let result = list.compactMap { result in
                if case let .object(value) = result {
                    return value
                }
                return nil
            }
            
            for newQuote in result {
                if let oldQuote = quotes.first(where: { $0.c == newQuote.c }) {
                    let mergedQuote = oldQuote.merged(with: newQuote)
                    quotes.remove(oldQuote)
                    quotes.insert(mergedQuote)
                } else {
                    quotes.insert(newQuote)
                }
            }
        } catch {
            
        }
        return Array(quotes)
    }
    
    func removeAll() {
        quotes.removeAll()
    }
}
