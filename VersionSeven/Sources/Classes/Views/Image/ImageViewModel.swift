import Foundation
import Kingfisher
import UIKit

protocol ImageViewModelDelegate: AnyObject {
    func didReceive(result: Result<UIImage, Error>)
}

final class ImageViewModel {
    
    weak var delegate: ImageViewModelDelegate?
    let url: URL?
    
    init?(url: URL?) {
        self.url = url
    }
    
    func set(result: Result<RetrieveImageResult, KingfisherError>) {
        switch result {
        case .success(let value):
            delegate?.didReceive(result: .success(value.image))
        case .failure(let error):
            delegate?.didReceive(result: .failure(error))
        }
    }
}
