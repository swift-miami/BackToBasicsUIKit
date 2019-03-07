/*
 - UITabBarController
    - How to customize it
    - How to programmatically change the tab
    - How to dynamically create tabs
 - UINavigationController:
    - How to customize the nav bar.
    - How to push VC's
    - How to present a VC modally with all different kinds (pageSheet, fullScreen) and styles (flip, etc)
 */

import UIKit

class NilsonViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        let vc1 = UIViewController()
        vc1.title = "1"
        vc1.view.backgroundColor = .blue

        let vc2 = UIViewController()
        vc2.title = "2"
        vc2.view.backgroundColor = .green

        let vc3 = SpinnerVC()
        vc3.title = "Spinner"

        let vc4 = PresentationsVC()
        vc4.title = "Presentations"

        let vc5 = UIViewController()
        vc5.title = "5"
        vc5.view.backgroundColor = .orange

        viewControllers = [vc1, vc2, vc3, vc4, vc5]

        // Programmatically change the tab
        selectedIndex = 1

        // Appearance
        tabBar.tintColor = .orange
        tabBar.barTintColor = .purple
        tabBar.unselectedItemTintColor = .green
    }

}

extension NilsonViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == "2" {
            return false
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        // Dynamically create tabs
        if viewController.title == "1" {
            let vc = UIViewController()
            vc.title = "\(viewControllers!.count + 1)"
            setViewControllers(viewControllers! + [vc], animated: true)
        }
    }

}
