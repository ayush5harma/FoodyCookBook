import Foundation

class NetworkManager {
    
    static func getPopularRecipe(response: @escaping (Meal?, String?)-> Void) {
        guard let url = URL(string: "\(Constants.API_URL)random.php") else {
            response(nil, "Could not process request. Please try again later.")
            return
        }
        sendRequest(url: url) { (data, error) in
            if error != nil {
                response(nil, error?.localizedDescription)
                return
            }
            guard let data = data else {
                response(nil, "Could not get correct data. Please try agian later")
                return
            }
            print("here")
            do {
                let result = try JSONDecoder().decode(Recipe.self, from: data)
                response(result.meals[0], nil)
            } catch {
                response(nil, "Failed to parse request data")
            }
        }
    }
    
    static func getCategories(response: @escaping ([Category]?, String?)-> Void) {
        guard let url = URL(string: "\(Constants.API_URL)categories.php") else {
            response(nil, "Could not process request. Please try again later.")
            return
        }
        sendRequest(url: url) { (data, error) in
            if error != nil {
                response(nil, error?.localizedDescription)
                return
            }
            guard let data = data else {
                response(nil, "Could not get correct data. Please try agian later")
                return
            }
            do {
                let result = try JSONDecoder().decode(Categories.self, from: data)
                print(result)
                response(result.categories, nil)
            } catch {
                response(nil, "Failed to parse request data")
            }
        }
    }
   
    static func getCountries(response: @escaping ([Country]?, String?)-> Void) {
        guard let url = URL(string: "\(Constants.API_URL)list.php?a=list") else {
            response(nil, "Could not process request. Please try again later.")
            return
        }
        sendRequest(url: url) { (data, error) in
            if error != nil {
                response(nil, error?.localizedDescription)
                return
            }
            guard let data = data else {
                response(nil, "Could not get correct data. Please try agian later")
                return
            }
            do {
                let result = try JSONDecoder().decode(Areas.self, from: data)
                print(result)
                response(result.meals, nil)
            } catch {
                response(nil, "Failed to parse request data")
            }
        }
    }
    
    static func getMeals(by query: String, response: @escaping ([Meal]?, String?)-> Void) {
        guard let url = URL(string: "\(Constants.API_URL)\(query)") else {
            response(nil, "Could not process request. Please try again later.")
            return
        }
        sendRequest(url: url) { (data, error) in
             if error != nil {
                response(nil, error?.localizedDescription)
                return
            }
            guard let data = data else {
                response(nil, "Could not get correct data. Please try agian later")
                return
            }
            do {
                let result = try JSONDecoder().decode(Recipe.self, from: data)
                response(result.meals, nil)
            } catch {
                response(nil, "Failed to parse request data")
            }
        }
    }

    private static func sendRequest(url: URL, completion: @escaping (Data?, Error?)-> Void) {
        debugPrint("request sent to \(url)")
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                debugPrint("Request failed", error)
                return
            } else if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
    }
}
