import TabloidView
import UIKit

final class QuotesViewController: UIViewController {
    
    private lazy var tabloidView: TabloidView = {
        let view = TabloidView(style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        return view
    }()
    
    var viewModel: QuotesViewModel? {
        didSet {
            tabloidView.viewModel = viewModel?.tabloidViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        viewModel?.viewDidLoad()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(tabloidView)
        NSLayoutConstraint.activate([
            tabloidView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabloidView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tabloidView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabloidView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
