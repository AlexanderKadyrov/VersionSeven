import TabloidView
import UIKit

final class QuotesViewController: UIViewController {
    
    private lazy var tabloidView: TabloidView = {
        let view = TabloidView(style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(cellIdentifiers: ["QuotesTabloidCellView"])
        view.contentInsetAdjustmentBehavior = .never
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = .zero
        }
        return view
    }()
    
    var viewModel: QuotesViewModel? {
        didSet {
            tabloidView.viewModel = viewModel?.tabloidViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolbar()
        configureViews()
        viewModel?.viewDidLoad()
    }
    
    private func configureToolbar() {
        title = "Quotes"
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
        barButtonItem.tintColor = .black
        navigationItem.rightBarButtonItems = [barButtonItem]
    }
    
    private func configureViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        view.addSubview(tabloidView)
        NSLayoutConstraint.activate([
            tabloidView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tabloidView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tabloidView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabloidView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    @objc
    private func actionEdit() {
        present(stocksViewController(), animated: true)
    }
    
    private func stocksViewController() -> UINavigationController {
        let stocks = (viewModel?.tickers ?? []).map { Stock(ticker: $0, selected: true) }
        let viewModel = StocksViewModel(stocks: stocks)
        let viewController = StocksViewController()
        viewController.viewModel = viewModel
        let navigationController = NavigationController(
            rootViewController: viewController
        )
        return navigationController
    }
}
