import Foundation
import UIKit

class JSONPlaceholderNetworking {
    
    public func getImages(_ imageCount: Int, completion: @escaping ([Image]) -> ()) {
        getRequest("https://jsonplaceholder.typicode.com/photos?_limit=10") { data in
            let images = try! JSONDecoder().decode([Image].self, from: data)
            completion(images)
        }
    }

    private func getRequest(_ url: String, completion: @escaping (Data) -> ()) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, let _ = response, error == nil else {
                fatalError()
            }
            completion(data)
        }
        session.resume()
    }
}

struct Image: Codable {
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// THANK YOU STACK OVERFLOW
extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
