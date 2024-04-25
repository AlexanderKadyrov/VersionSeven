import TabloidView
import Foundation

final class StocksViewModel {
    
    let tabloidViewModel = TabloidViewModel()
    let stocks: [Stock]
    
    init(stocks: [Stock]) {
        self.stocks = stocks
    }
    
    func viewDidLoad() {
        
    }
    
    func actionDone() {
        
    }
}
