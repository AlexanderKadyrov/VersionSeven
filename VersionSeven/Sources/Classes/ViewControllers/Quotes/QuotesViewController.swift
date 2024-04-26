import TabloidView
import UIKit

final class QuotesViewController: UIViewController {
    
    private lazy var tabloidView: TabloidView = {
        let view = TabloidView(style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(cellIdentifiers: ["QuoteTabloidCellView"])
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
        guard let stocks = viewModel?.stocks else { return }
        present(stocksViewController(stocks: stocks), animated: true)
    }
    
    private func stocksViewController(stocks: Set<Stock>) -> UINavigationController {
        let stocksViewModel = StocksViewModel(stocks: stocks)
        let stocksViewController = StocksViewController()
        stocksViewController.viewModel = stocksViewModel
        let navigationController = NavigationController(
            rootViewController: stocksViewController
        )
        stocksViewModel.delegate = viewModel
        return navigationController
    }
}
