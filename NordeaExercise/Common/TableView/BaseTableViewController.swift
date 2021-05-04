//
//  BaseTableViewController.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 1.5.2021.
//

import UIKit

protocol UpdateListProtocol: AnyObject {
    func update(with items: [ListItemViewModel])
}

extension UpdateListProtocol where Self: BaseTableViewController {
    func update(with items: [ListItemViewModel]) {
        self.items = items
    }
}

class BaseTableViewController: UITableViewController {

    fileprivate var items = [ListItemViewModel]() {
        didSet { tableView.reloadData() }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = items[indexPath.row]

        let itemIdentifier = type(of: viewModel).associatedListItem.identifier
        tableView.register(UINib(nibName: itemIdentifier, bundle: nil), forCellReuseIdentifier: itemIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: itemIdentifier, for: indexPath) as! ListItem

        cell.configure(with: viewModel)

        return cell as! UITableViewCell
    }
}
