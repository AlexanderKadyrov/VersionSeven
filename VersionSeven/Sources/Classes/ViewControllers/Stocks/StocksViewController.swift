import TabloidView
import Foundation
import UIKit

final class StocksViewController: UIViewController {
    
    private lazy var tabloidView: TabloidView = {
        let view = TabloidView(style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(cellIdentifiers: ["StockTabloidCellView"])
        view.contentInsetAdjustmentBehavior = .never
        view.separatorStyle = .singleLine
        view.backgroundColor = .white
        if #available(iOS 15.0, *) {
            view.sectionHeaderTopPadding = .zero
        }
        return view
    }()
    
    private var hasEnabledOneStock: Bool {
        return viewModel?.hasEnabledOneStock ?? false
    }
    
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
        configureDone()
        if hasEnabledOneStock {
            configureUndo()
        } else {
            configureRedo()
        }
    }
    
    private func configureUndo() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(actionUndo))
        barButtonItem.tintColor = .black
        navigationItem.leftBarButtonItems = [barButtonItem]
    }
    
    private func configureRedo() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(actionRedo))
        barButtonItem.tintColor = .black
        navigationItem.leftBarButtonItems = [barButtonItem]
    }
    
    private func configureDone() {
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
    private func actionUndo() {
        configureRedo()
        viewModel?.actionUndo()
    }
    
    @objc
    private func actionRedo() {
        configureUndo()
        viewModel?.actionRedo()
    }
    
    @objc
    private func actionDone() {
        dismiss(animated: true) { [weak self] in
            self?.viewModel?.actionDone()
        }
    }
}
