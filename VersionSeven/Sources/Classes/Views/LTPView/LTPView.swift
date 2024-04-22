import Foundation
import UIKit

final class LTPView: UIView {
    
    enum Constants {
        static let cornerRadius: CGFloat = 6
        enum TextLabel {
            static let insets = UIEdgeInsets(top: .zero, left: 4, bottom: .zero, right: 4)
        }
    }
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    var ltp: LTP = .equal(.zero) {
        didSet {
            set(ltp: ltp)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    private func configureViews() {
        layer.cornerRadius = Constants.cornerRadius
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.TextLabel.insets.right),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.TextLabel.insets.left),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func set(ltp: LTP) {
        switch ltp {
        case .equal(let value):
            backgroundColor = .clear
            textLabel.textColor = .black
            set(value: value)
        case .down(let value):
            backgroundColor = .red
            textLabel.textColor = .white
            set(value: value)
        case .up(let value):
            backgroundColor = .systemGreen
            textLabel.textColor = .white
            set(value: value)
        }
    }
    
    private func set(value: Double) {
        textLabel.text = "\(value)"
    }
}
