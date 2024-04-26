import Foundation

extension Bundle {
    
    func file(name: String, type: String) -> Data? {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { return nil }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        return data
    }
}
