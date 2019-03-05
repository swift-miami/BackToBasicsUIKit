/*
 - UITableView
    - How to conform to the delegate and dataSource protocols
    - Self sizing cells
 - UIRefreshControl
    - How to customize it
 */


import UIKit

class PauloViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!

    private let viewModel = PauloViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

        viewModel.loadData(
            progress: { [weak self] value in
                // Show the load percentage
                self?.title = "Loading \(Int(value * 100))%"
            },
            completion: { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.title = strongSelf.viewModel.title
                strongSelf.tableView.reloadData()
        })
    }
}

extension PauloViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.totalSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension PauloViewController: UITableViewDelegate {
    
}
