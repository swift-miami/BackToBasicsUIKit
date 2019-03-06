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
    private let refreshControl = UIRefreshControl()

    private let viewModel = PauloViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

}

// MARK: - Private Methods

extension PauloViewController {

    private func setupUI() {
        title = viewModel.title

        // Add the refresh control
        tableView.addSubview(refreshControl)
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        let headerNib = UINib(nibName: "PauloHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PauloHeaderView.identifier)
    }

    // Handle what happens when the refresh control is pulled down to refresh
    @objc private func refreshData() {
        loadData()
    }

    /// Fetch the data and update the table
    private func loadData() {
        refreshControl.beginRefreshing()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")

        viewModel.loadData(
            progress: { [weak self] value in
                // Show the load percentage
                self?.refreshControl.attributedTitle = NSAttributedString(string: "Loading \(Int(value * 100))%")
            },
            completion: { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.title = strongSelf.viewModel.title
                strongSelf.refreshControl.endRefreshing()
                strongSelf.refreshControl.attributedTitle = NSAttributedString(string: "Last updated \(strongSelf.viewModel.lastUpdated)")

                // Animate in the rows instead of the standard tableView.reloadData
                let sections = IndexSet(integersIn: 0...1)
                strongSelf.tableView.reloadSections(sections, with: .automatic)
        })
    }
}

// MARK: - Data Source Delegate Methods

extension PauloViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.totalSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "SH"
        return cell
    }

    // MARK: - Use a custom header

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: PauloHeaderView.identifier) as? PauloHeaderView else {
                return nil
        }
        headerCell.setTitle("Section \(section)")
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PauloHeaderView.height
    }
}

// MARK: - Delegate Methods

extension PauloViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
