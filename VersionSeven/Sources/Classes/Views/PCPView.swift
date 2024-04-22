import Foundation
import UIKit

final class PCPView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    var pcp: Double? {
        didSet {
            set(pcp: pcp)
        }
    }
    
    var text: String? {
        set { textLabel.text = newValue }
        get { return textLabel.text }
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
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func set(pcp: Double?) {
        let pcp = pcp ?? .zero
        if pcp == .zero {
            textLabel.textColor = .black
        } else {
            textLabel.textColor = pcp > .zero ? .systemGreen : .red
        }
        textLabel.text = "\(pcp)%"
    }
}
