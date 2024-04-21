import UIKit

final class QuotesViewController: UIViewController {
    
    var viewModel: QuotesViewModel? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        viewModel?.viewDidLoad()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
    }
}
