import UIKit

class RecipeVC: UIViewController {
    
    @IBOutlet var categoriesCollectionView : UICollectionView!
    @IBOutlet var countriesTableView : UITableView!
    
    @IBOutlet var popularRecipeNameLabel: UILabel!
    @IBOutlet var popularRecipeTypeLabel: UILabel!
    @IBOutlet var popularRecipeImageView: CustomImageView!
    
    let networkManager = NetworkManager()
    var categories = [Category]()
    var countries = [Country]()
    var mealType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        
        // get random recipe and categories
        getPopularRecipe()
        getCategories()
        getCountries()
    }
    
    func getPopularRecipe(){
        NetworkManager.getPopularRecipe { (meal, errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            if let meal = meal {
                DispatchQueue.main.async {
                    self.popularRecipeNameLabel.text = meal.name
                    self.popularRecipeTypeLabel.text = meal.type
                    if let url = URL(string: "\(meal.thumbnail)") {
                        self.popularRecipeImageView.loadImage(from: url)
                    }
                }
            }
        }
    }
    
    func getCategories() {
        NetworkManager.getCategories { (categories, errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            if let categories = categories {
                DispatchQueue.main.async {
                    self.categories = categories
                    self.categoriesCollectionView.reloadData()
                }
            }
        }
    }
    
    func getCountries() {
        NetworkManager.getCountries { (countries, errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
                return
            }
            if let countries = countries {
                DispatchQueue.main.async {
                    self.countries = countries
                    self.countriesTableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let senderData = sender as? String {
            if let mealVC = segue.destination as? MealsVC {
                mealVC.mealQuery = senderData
                mealVC.mealsType = mealType
            }
        }
    }
}

// MARK:- Categories CollectionView
extension RecipeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.categoryCell, for: indexPath) as! CategoryCell
        cell.setup(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 100 is for small peek to show to the next card
        let width = collectionView.bounds.width - 100
        let height : CGFloat = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryName = categories[indexPath.item].name
        mealType = categoryName
        self.performSegue(withIdentifier: Constants.SEGUE_SHOW_MEALS, sender: "filter.php?c=\(categoryName)")
    }
    
}
// MARK:- Recipe By Country TableView
extension RecipeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.countryCell, for: indexPath) as! CountryCell
        cell.setup(country: countries[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let areaName = countries[indexPath.item].name
        mealType = areaName
        self.performSegue(withIdentifier: Constants.SEGUE_SHOW_MEALS, sender: "filter.php?a=\(areaName)")
    }
}

