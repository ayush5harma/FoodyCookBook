import UIKit

class MealDetailVC: UIViewController {
    
    @IBOutlet var headerView: HeaderView!
    @IBOutlet var mealDetailTableView: UITableView!

    var meal: Meal!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mealDetailTableView.dataSource = self
        
        if let meal = meal {
            headerView.setup(meal: meal)
            getMealInfo()
        }

        // remove space before tableView
        mealDetailTableView.contentInsetAdjustmentBehavior = .never
        mealDetailTableView.allowsSelection = false
        mealDetailTableView.separatorStyle = .none
    }
    
    func getMealInfo() {
        NetworkManager.getMeals(by: "lookup.php?i=\(meal.id)") { (meals, errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            DispatchQueue.main.async {
                if let meals = meals {
                    self.meal = meals[0]
                    self.mealDetailTableView.reloadData()
                }
            }
        }
    }
}

extension MealDetailVC :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mealCell, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = meal.instructions
        
        return cell
    }
}
