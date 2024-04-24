import Foundation

enum LTP: Codable, Hashable, Comparable {
    
    case equal(Double)
    case down(Double)
    case up(Double)
    
    var rawValue: Double {
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
        let value = try container.decode(Double.self)
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
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}
