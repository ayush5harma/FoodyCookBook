import Foundation

struct Category : Codable {
    var id: String
    var name: String
    var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
    }
}
