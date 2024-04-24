import Foundation
import UIKit

final class LTPView: UIView {
    
    enum Constants {
        static let cornerRadius: CGFloat = 4
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
    
    var ltp: LTP? {
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
    
    private func set(ltp: LTP?) {
        guard let ltp = ltp else {
            setEqual(value: .zero)
            return
        }
        switch ltp {
        case .equal(let value):
            setEqual(value: value)
        case .down(let value):
            setDown(value: value)
        case .up(let value):
            setUp(value: value)
        }
    }
    
    private func setEqual(value: Double) {
        backgroundColor = .clear
        textLabel.textColor = .black
        set(value: value)
    }
    
    private func setDown(value: Double) {
        backgroundColor = .red
        textLabel.textColor = .white
        set(value: value)
    }
    
    private func setUp(value: Double) {
        backgroundColor = .systemGreen
        textLabel.textColor = .white
        set(value: value)
    }
    
    private func set(value: Double) {
        textLabel.text = "\(value)"
    }
}
