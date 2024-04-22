import Foundation

enum LTP: Codable, Comparable {
    
    case equal(Float)
    case down(Float)
    case up(Float)
    
    var rawValue: Float {
        switch self {
        case .equal(let value):
            return value
        case .down(let value):
            return value
        case .up(let value):
            return value
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Float.self)
        self = .equal(value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .equal(let value):
            try container.encode(value)
        case .down(let value):
            try container.encode(value)
        case .up(let value):
            try container.encode(value)
        }
    }
}
