//
//  MainTableViewController.swift
//  iOSAnimations
//
//  Created by Ivan Corchado Ruiz on 2/2/19.
//  Copyright © 2019 ivancr. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    private let demoTypes = ["Alejo",
                             "Chris",
                             "Freddy",
                             "Giannini",
                             "Gio",
                             "Iván",
                             "Jim",
                             "Nilson",
                             "Paulo",
                             "Ryan",
                             "Jimmy"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        navigationItem.title = "Back to Basics: UIKit"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let title = demoTypes[indexPath.row]
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        cell.accessoryType = .disclosureIndicator
        cell.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var demoVC = UIViewController()

        switch indexPath.row {
        case 0: demoVC = AlejoViewController()
        case 1: demoVC = ChrisViewController()
        case 2: demoVC = FreddyViewController()
        case 3: demoVC = GianniniViewController()
        case 4: demoVC = GioViewController()
        case 5: demoVC = IvanViewController()
        case 6: demoVC = JimViewController()
        case 7: demoVC = NilsonViewController()
        case 8: demoVC = PauloViewController()
        case 9: demoVC = RyanViewController()
        case 10: demoVC = JimmyViewController()
            
        default:
            assertionFailure("Cell not configured yet")
        }
        
        if indexPath.row == 10 {
            let storyboard = UIStoryboard(name: "Jimmy", bundle: nil)
            let destination = storyboard.instantiateViewController(withIdentifier: "JimmyViewController") as! JimmyViewController
            navigationController?.pushViewController(destination, animated: true)
        } else {
        demoVC.navigationItem.title = demoTypes[indexPath.row]
        navigationController?.pushViewController(demoVC, animated: true)
        }
    }
}
