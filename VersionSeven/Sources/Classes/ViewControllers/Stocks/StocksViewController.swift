import TabloidView
import Foundation
import UIKit

final class StocksViewController: UIViewController {
    
    private lazy var tabloidView: TabloidView = {
        let view = TabloidView(style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(cellIdentifiers: ["StocksTabloidCellView"])
        view.contentInsetAdjustmentBehavior = .never
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = .zero
        }
        return view
    }()
    
    var viewModel: StocksViewModel? {
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
        title = "Stocks"
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(actionDone))
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
    private func actionDone() {
        viewModel?.actionDone()
    }
}
