//
//  PresentationsVC.swift
//  BackToBasicsUIKit
//
//  Created by Nilson Nascimento on 3/7/19.
//  Copyright © 2019 SwiftMiami. All rights reserved.
//

import UIKit

class PresentationsVC: UITableViewController {

    enum Cell: Int {
        case fullScreen
        case pageSheet
        case formSheet
        case currentContext
        case overFullScreen
        case overCurrentContext
        case popover

        case coverVertical
        case flipHorizontal
        case crossDissolve
        case partialCurl

        static let count = 11

        var title: String {
            get {
                switch self {
                case .fullScreen:
                    return "FullScreen - Covers the screen"
                case .pageSheet:
                    return "PageSheet - Partially covers the underlying content"
                case .formSheet:
                    return "FormSheet - Displays the content centered in the screen"
                case .currentContext:
                    return "CurrentContext - Displayed over another view controller’s content"
                case .overFullScreen:
                    return "OverFullScreen - Covers the screen"
                case .overCurrentContext:
                    return "OverCurrentContext - Displayed over another view controller’s content"
                case .popover:
                    return "Popover - Displayed in a popover view"

                case .coverVertical:
                    return "Cover Vertical"
                case .flipHorizontal:
                    return "Flip Horizontal"
                case .crossDissolve:
                    return "Cross Dissolve"
                case .partialCurl:
                    return "Partial Curl"
                }
            }
        }

        var viewController: UIViewController {
            get {
                let vc = UIViewController()
                vc.view.backgroundColor = .lightGray

                switch self {
                case .fullScreen:
                    vc.modalPresentationStyle = .fullScreen
                case .pageSheet:
                    vc.modalPresentationStyle = .pageSheet
                case .formSheet:
                    vc.modalPresentationStyle = .formSheet
                case .currentContext:
                    vc.modalPresentationStyle = .currentContext
                case .overFullScreen:
                    vc.modalPresentationStyle = .overFullScreen
                case .overCurrentContext:
                    vc.modalPresentationStyle = .overCurrentContext
                case .popover:
                    vc.modalPresentationStyle = .popover

                case .coverVertical:
                    vc.modalPresentationStyle = .formSheet
                    vc.modalTransitionStyle = .coverVertical
                case .flipHorizontal:
                    vc.modalPresentationStyle = .formSheet
                    vc.modalTransitionStyle = .flipHorizontal
                case .crossDissolve:
                    vc.modalPresentationStyle = .formSheet
                    vc.modalTransitionStyle = .crossDissolve
                case .partialCurl:
                    vc.modalTransitionStyle = .partialCurl
                }

                return vc
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cell.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Cell(rawValue: indexPath.row)!.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cellInfo = Cell(rawValue: indexPath.row)
        present(cellInfo!.viewController, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
