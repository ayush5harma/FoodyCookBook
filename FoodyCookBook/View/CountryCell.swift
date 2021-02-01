import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func setup(country: Country){
        nameLabel.text = country.name
        if country.name.lowercased() == "unknown" {
            thumbnailImageView.image = UIImage(systemName: "photo")
        } else {
            thumbnailImageView.image = UIImage(named: country.name.lowercased())
        }
    }
    
    override func awakeFromNib() {
        thumbnailImageView.layer.cornerRadius = 30.0 // thumbnailImageView.bounds.width / 2
        thumbnailImageView.clipsToBounds = true
    }
}
