/*
 - UIToolbar
    - How to add button
    - How to add spacing between buttons
 - UIPageViewControler
    - How to use it
 */

import UIKit

class IvanViewController: UIViewController {

    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()

        toolBar.setItems([cameraButton, flexSpaceButton, organizeButton, fixedSpaceButton, bookmarkButton], animated: false)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        return toolBar
    }()

    private let flexSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    private var fixedSpaceButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        button.width = 44
        return button
    }()

    private lazy var cameraButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
    }()

    private lazy var bookmarkButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: nil)
    }()

    private lazy var organizeButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: nil)
    }()

    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal,
                                                      options: nil)
        pageViewController.dataSource = self
        pageViewController.view.backgroundColor = .lightGray
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        return pageViewController
    }()

    private lazy var controllers: [UIViewController] = {
        let texts = ["Here's to the crazy ones.\nThe misfits.\nThe rebels.\nThe troublemakers.\nThe round pegs in the square holes.",
                     "The ones who see things differently.\n\nThey're not fond of rules.\n\nAnd they have no respect for the status quo.",
                     "You can quote them, disagree with them, glorify or vilify them.\n\nAbout the only thing you can't do is ignore them.",
                     "Because they change things.\n\nThey push the human race forward.",
                     "And while some may see them as the crazy ones, we see genius.",
                     "Because the people who are crazy enough to think they can change the world, are the ones who do.\n\n"]

        let colors = [UIColor(red: 0.37, green: 0.74, blue: 0.24, alpha: 1.0),
                      UIColor(red: 1.00, green: 0.73, blue: 0.00, alpha: 1.0),
                      UIColor(red: 0.97, green: 0.51, blue: 0.00, alpha: 1.0),
                      UIColor(red: 0.89, green: 0.22, blue: 0.22, alpha: 1.0),
                      UIColor(red: 0.59, green: 0.22, blue: 0.60, alpha: 1.0),
                      UIColor(red: 0.00, green: 0.61, blue: 0.87, alpha: 1.0)]

        return [PagedViewController(backgroundColor: colors[0], text: texts[0]),
                PagedViewController(backgroundColor: colors[1], text: texts[1]),
                PagedViewController(backgroundColor: colors[2], text: texts[2]),
                PagedViewController(backgroundColor: colors[3], text: texts[3]),
                PagedViewController(backgroundColor: colors[4], text: texts[4]),
                PagedViewController(backgroundColor: colors[5], text: texts[5])]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        pageViewController.setViewControllers([controllers[0]], direction: .forward, animated: false, completion: nil)

        view.addConstraints([
            pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}

extension IvanViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let index = controllers.firstIndex(of: viewController)!

        if index - 1 >= 0 {
            return controllers[index - 1]
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let index = controllers.firstIndex(of: viewController)!

        if index + 1 < controllers.count {
            return controllers[index + 1]
        }

        return nil
    }
}


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
