import TabloidView
import Foundation
import UIKit

final class QuotesTabloidCellView: TabloidCellView {
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    
    private let cLabel: UILabel = {
        let label = UILabel()
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
        
        contentView.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    override func fill(viewModel: TabloidCellViewModel?) {
        super.fill(viewModel: viewModel)
        guard let viewModel = viewModel as? QuotesTabloidCellViewModel else { return }
        cLabel.text = viewModel.quotes.c
    }
}
