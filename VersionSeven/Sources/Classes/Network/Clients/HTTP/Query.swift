import Foundation

struct Query<P: Codable>: Codable {
    let cmd: String
    let params: P
}
