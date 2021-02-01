import Foundation

struct Country : Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strArea"
    }
}
