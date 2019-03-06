import UIKit

/// The ViewController class used as a page in the UIPageViewController demo.
class PagedViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()

    convenience init(backgroundColor: UIColor, text: String) {
        self.init()

        view.backgroundColor = backgroundColor
        label.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addConstraints([label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                             label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                             label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                             label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)])
    }
}
