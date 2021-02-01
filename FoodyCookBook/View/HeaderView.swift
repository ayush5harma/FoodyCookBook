import UIKit

class HeaderView: UIView {
    
    @IBOutlet var mealThumnail: CustomImageView!
    @IBOutlet var mealName: UILabel!
    @IBOutlet var mealType: UILabel!
    
    func setup(meal: Meal){
        mealName.text = meal.name
        mealType.text = meal.type
        
        if let url = URL(string: meal.thumbnail) {
            mealThumnail.loadImage(from: url)
        }
    }
}
