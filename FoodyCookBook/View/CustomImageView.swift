import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var ImagedownloadTask: URLSessionDataTask!
    var spinner = UIActivityIndicatorView(style: .large)
    
    func loadImage(from url: URL){
        // reset previous image
        image = nil
        
        addSpinner()
        
        // cancel previous download task
        if let ImagedownloadTask = ImagedownloadTask {
            ImagedownloadTask.cancel()
        }
        
        // check image cache
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            removeSpinner()
            image = imageFromCache
            return
        }
        
        ImagedownloadTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                if let image = UIImage(data: data) {
                    //cache image
                    imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                    
                    DispatchQueue.main.async {
                        self.removeSpinner()
                        self.image = image
                        self.contentMode = .scaleAspectFill
                    }
                }
            }
        });
        ImagedownloadTask.resume()
    }
    
    func addSpinner(){
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner(){
        spinner.stopAnimating()
    }
}
