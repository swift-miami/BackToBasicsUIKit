/*
 - UITableView
    - How to conform to the delegate and dataSource protocols
    - Self sizing cells
 - UIRefreshControl
    - How to customize it
 */


import UIKit
import MobileCoreServices

class PauloViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private let viewModel = PauloViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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

        // Register cells
        let headerNib = UINib(nibName: String(describing: PauloHeaderView.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: PauloHeaderView.identifier)

        let cellNib = UINib(nibName: String(describing: PauloTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: PauloTableViewCell.identifier)

        // Setting this gives us a slight performance boost, from the docs:
        //   "using estimation allows you to defer some of the cost of geometry
        //    calculation from load time to scrolling time."
        tableView.estimatedRowHeight = PauloTableViewCell.estimatedRowHeight

        // Center cells on iPad so its a bit more usable
        tableView.cellLayoutMarginsFollowReadableWidth = true

        // Set up delegates (the first two can be done in IB)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.dragDelegate = self
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

    /// Remove a user and update the table
    private func deleteUser(at indexPath: IndexPath) {
        viewModel.removeUser(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    /// Make a user an owner and update the table
    private func ownerifyUser(at indexPath: IndexPath) {
        viewModel.ownerifyUser(at: indexPath)
        // FIXME: We could make this nicer by doing a custom animation deleting the row
        // from one section and inserting the row in another. But we're lazy so...
        tableView.reloadData()
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

    // MARK: - Cell Methods

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PauloTableViewCell.identifier,
                                                       for: indexPath) as? PauloTableViewCell else {
                                                        fatalError("Could not dequeue user cell")
        }
        let user = viewModel.userData(at: indexPath)
        cell.setData(name: user.name ?? user.username, imageURL: user.avatarURL, location: user.location)
        return cell
    }

    // MARK: - Header Methods

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: PauloHeaderView.identifier) as? PauloHeaderView else {
            return nil
        }

        headerCell.setTitle(viewModel.titleForSection(section))
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PauloHeaderView.height
    }
}

// MARK: - Delegate Methods

extension PauloViewController: UITableViewDelegate {

    // Handle tapping on cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: iOS 7- Cell Actions

    // Pre-iOS 8 way of handling swiping on cells to delete.
    // This is ignored due to the implementation of editActionsForRowAt below.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Add support for swiping cells to delete them
        if editingStyle == .delete {
            deleteUser(at: indexPath)
        }
    }

    // MARK: iOS 10- Cell Actions

    // Pre-iOS 11 way of handling swiping on cells and have actions.
    // This is ignored due to the implementation of the leading/trailingSwipAction methods below.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Create action for making a user an owner
        let ownerAction = UITableViewRowAction(style: .normal, title: "☝️") { [weak self] _, indexPath in
            self?.ownerifyUser(at: indexPath)
        }
        ownerAction.backgroundColor = UIColor(named: "blue")

        // Create action for deleting a user
        let deleteAction = UITableViewRowAction(style: .destructive, title: "🔫") { [weak self] _, indexPath in
            self?.deleteUser(at: indexPath)
        }

        // Return the actions for each cell depending on its section
        if indexPath.section == 0 {
            return [deleteAction]
        }
        return [ownerAction, deleteAction]
    }

    // MARK: iOS 11+ Cell Actions

    // Add ownerify action on the leading side
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let ownerAction = UIContextualAction(style: .normal, title: "☝️") { [weak self] _, _, completionHandler in
            self?.ownerifyUser(at: indexPath)
            completionHandler(true)
        }
        ownerAction.backgroundColor = UIColor(named: "blue")
        return UISwipeActionsConfiguration(actions: [ownerAction])
    }

    // Add delete action on the trailing side
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "🔫") { [weak self] _, _, completionHandler in
            self?.deleteUser(at: indexPath)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Drag Methods

extension PauloViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return dragItems(for: indexPath)
    }

    /// Handle dragging of items at a given index path
    private func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let user = viewModel.userData(at: indexPath)

        let itemProvider = NSItemProvider()

        // Define identifiers
        let plainTextIdentifier = kUTTypePlainText as String // Requires import MobileCoreServices
        let jpegIdentifier = kUTTypeJPEG as String

        let cell = tableView.cellForRow(at: indexPath) as? PauloTableViewCell
        let imageData = cell?.loadedImage?.jpegData(compressionQuality: 0.8)

        // Register the text representation
        itemProvider.registerDataRepresentation(forTypeIdentifier: plainTextIdentifier, visibility: .all) { completion in
            let data = user.username.data(using: .utf8)
            completion(data, nil)
            return nil
        }

        // Register the image representation
        itemProvider.registerDataRepresentation(forTypeIdentifier: jpegIdentifier, visibility: .all) { completion in
            guard let imageData = imageData else {
                completion(nil, nil)
                return nil
            }

            completion(imageData, nil)
            return nil
        }

        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
