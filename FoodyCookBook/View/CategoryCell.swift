import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var thumbnailImageView: CustomImageView!
    
    func setup(category: Category){
        categoryNameLabel.text = category.name
        if let url = URL(string: category.thumbnail){
            thumbnailImageView.loadImage(from: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }
}
