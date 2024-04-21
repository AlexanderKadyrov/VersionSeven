import TabloidView
import Foundation
import UIKit

final class QuotesTabloidCellView: TabloidCellView {
    
    enum Constants {
        enum ContainerView {
            static let insets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            static let spacing: CGFloat = 4
        }
    }
    
    private lazy var topView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cView, ltpView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var bottomView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topView, bottomView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = Constants.ContainerView.spacing
        view.axis = .vertical
        return view
    }()
    
    private let cView: CView = {
        let label = CView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ltpView: LTPView = {
        let label = LTPView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameView: NameView = {
        let label = NameView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    private func configureViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.ContainerView.insets.right),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.ContainerView.insets.bottom),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ContainerView.insets.left),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.ContainerView.insets.top)
        ])
    }
    
    override func fill(viewModel: TabloidCellViewModel?) {
        super.fill(viewModel: viewModel)
        guard let viewModel = viewModel as? QuotesTabloidCellViewModel else { return }
        nameView.text = [viewModel.quotes.ltr, viewModel.quotes.name].joined(separator: " | ")
        ltpView.ltp = viewModel.quotes.ltp
        cView.text = viewModel.quotes.c
    }
}
