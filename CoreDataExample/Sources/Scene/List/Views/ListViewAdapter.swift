//
//  ListViewAdapter.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 08.06.2022.
//

import UIKit
import CoreData

protocol ListViewAdapterDelegate: AnyObject {
    func didTap(index: Int)
    func removed(profile: Profile)
}

class ListViewAdapter: NSObject {
    
    // MARK: - Properties
    
    let identifier = "ListViewCell"
    var profiles: [NSManagedObject] = []
    weak var delegate: ListViewAdapterDelegate?
}

// MARK: - DataSource

extension ListViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        guard let profile = profiles[indexPath.row].value(forKey: "name") as? String else { return UITableViewCell() }

        cell.configureCell(with: profile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let profile = profiles[indexPath.row] as? Profile else { return }
            delegate?.removed(profile: profile)

            profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - Delegate

extension ListViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didTap(index: indexPath.row)
    }
}
