import UIKit

class MealCell: UITableViewCell {

    @IBOutlet var thumbnailImageView: CustomImageView?
    @IBOutlet var nameLabel: UILabel?
    
    func setup(meal: Meal){
        nameLabel?.text = meal.name
        if let url = URL(string: meal.thumbnail){
            thumbnailImageView?.loadImage(from: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImageView?.layer.cornerRadius = 20;
    }
}
