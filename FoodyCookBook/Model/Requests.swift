import Foundation

struct Recipe : Codable {
    var meals: [Meal]
}

struct Categories : Codable {
    var categories: [Category]
}

struct Areas : Codable {
    var meals: [Country]
}
