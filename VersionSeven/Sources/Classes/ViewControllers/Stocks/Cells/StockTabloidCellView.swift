import TabloidView
import Foundation
import UIKit

final class StockTabloidCellView: TabloidCellView {
    
    enum Constants {
        static let separatorInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: .zero)
        enum TickerLabel {
            static let insets = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
            static let height: CGFloat = 44
        }
    }
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override var cellViewModel: TabloidCellViewModel? {
        didSet {
            guard let cellViewModel = cellViewModel as? StockTabloidCellViewModel else { return }
            tickerLabel.text = cellViewModel.stock.ticker
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    private func configureViews() {
        separatorInset = Constants.separatorInset
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(tickerLabel)
        NSLayoutConstraint.activate([
            tickerLabel.heightAnchor.constraint(equalToConstant: Constants.TickerLabel.height),
            tickerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.TickerLabel.insets.right),
            tickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.TickerLabel.insets.left),
            tickerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tickerLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}
