import Foundation

struct Meal : Codable {
    var id: String
    var name: String
    var type: String?
    var thumbnail: String
    var youtubeLink: String?
    var category: String?
    var instructions: String?
    var tags: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case type = "strArea"
        case thumbnail = "strMealThumb"
        case youtubeLink = "strYoutube"
        case category = "strCategory"
        case instructions = "strInstructions"
        case tags = "strTags"
    }
}
