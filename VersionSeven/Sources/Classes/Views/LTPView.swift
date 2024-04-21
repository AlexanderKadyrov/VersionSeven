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
    
    var ltp: Float? {
        didSet {
            set(oldValue: oldValue, newValue: ltp)
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
    
    private func set(oldValue: Float?, newValue: Float?) {
        let oldValue = oldValue ?? .zero
        let newValue = newValue ?? .zero
        textLabel.text = "\(newValue)"
        if newValue > oldValue {
            backgroundColor = .systemGreen
            textLabel.textColor = .white
        } else if newValue < oldValue {
            backgroundColor = .red
            textLabel.textColor = .white
        } else {
            backgroundColor = .clear
            textLabel.textColor = .black
        }
    }
}
