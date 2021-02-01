import UIKit

class MealsVC: UITableViewController,UISearchBarDelegate {
    
    var mealQuery: String!
    var meals = [Meal]()
    var mealsType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mealsType = mealsType {
            navigationItem.title = mealsType
        }
        getMeals()
    }
    
    func getMeals() {
        NetworkManager.getMeals(by: mealQuery) { (meals, errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            DispatchQueue.main.async {
                if let meals = meals {
                    self.meals = meals
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meal = meals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mealCell, for: indexPath) as! MealCell
        cell.setup(meal: meal)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        self.performSegue(withIdentifier: Constants.SEGUE_SHOW_MEAL_DETAIL, sender: meal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var meal = sender as? Meal {
            if let mealDetailVC = segue.destination as? MealDetailVC {
                meal.type = self.mealsType
                mealDetailVC.meal = meal
            }
        }
    }
}
