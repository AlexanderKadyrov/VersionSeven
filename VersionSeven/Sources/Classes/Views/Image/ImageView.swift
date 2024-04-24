import Foundation
import Kingfisher
import UIKit

final class ImageView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ImageViewModel? {
        didSet {
            imageView.kf.setImage(with: viewModel?.url)
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
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
