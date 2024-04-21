import TabloidView
import Foundation
import UIKit

final class QuotesTabloidCellView: TabloidCellView {
    
    enum Constants {
        enum VerticalStackView {
            static let insets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            static let spacing: CGFloat = 4
        }
    }
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cLabel, nameLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = Constants.VerticalStackView.spacing
        view.axis = .vertical
        return view
    }()
    
    private let cLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
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
        
        contentView.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.VerticalStackView.insets.right),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.VerticalStackView.insets.bottom),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.VerticalStackView.insets.left),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.VerticalStackView.insets.top)
        ])
    }
    
    override func fill(viewModel: TabloidCellViewModel?) {
        super.fill(viewModel: viewModel)
        guard let viewModel = viewModel as? QuotesTabloidCellViewModel else { return }
        nameLabel.text = [viewModel.quotes.ltr, viewModel.quotes.name].joined(separator: " | ")
        cLabel.text = viewModel.quotes.c
    }
}
