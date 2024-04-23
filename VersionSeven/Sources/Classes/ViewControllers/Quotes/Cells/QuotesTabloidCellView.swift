import TabloidView
import Foundation
import UIKit

final class QuotesTabloidCellView: TabloidCellView {
    
    enum Constants {
        enum ContainerView {
            static let insets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            static let spacing: CGFloat = 4
        }
        enum BottomView {
            static let spacing: CGFloat = 8
        }
    }
    
    private lazy var topView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [cView, ltpView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var bottomView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameView, chgView, pcpView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = Constants.BottomView.spacing
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
    
    private let chgView: CHGView = {
        let label = CHGView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pcpView: PCPView = {
        let label = PCPView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var cellViewModel: TabloidCellViewModel? {
        didSet {
            guard let cellViewModel = cellViewModel as? QuotesTabloidCellViewModel else { return }
            chgView.chg = cellViewModel.quote.chg
            pcpView.pcp = cellViewModel.quote.pcp
            ltpView.ltp = cellViewModel.quote.ltp
            cView.text = cellViewModel.quote.c
            nameView.text = cellViewModel.text
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
}
