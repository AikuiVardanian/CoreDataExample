//
//  ListViewController.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit
import CoreData

final class ListViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var contentView = ListView()
    var listViewPresenter: ListViewOutput?
    var viewAdapter: ListViewAdapter?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        viewAdapter = contentView.viewAdapter
        viewAdapter?.delegate = self
    
        listViewPresenter?.getData()
    }
}

// MARK: - Navigation bar and alert

extension ListViewController {
    
    func setupNavigationBar() {
        title = "Profiles"
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addName))
        navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    @objc func addName() {
        
        let alert = UIAlertController(title: "New name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textFields = alert.textFields?.first,
                  let nameToSave = textFields.text,
                  let presenter = listViewPresenter else {return }
            
            presenter.addProfile(name: nameToSave)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - ViewInput

extension ListViewController: ListViewInput {
    func openDetailView(for profile: Profile) {
        let detailViewController = DetailViewController()
        detailViewController.detailViewOutput?.profile = profile

        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func update(with profiles: [Profile]) {

        viewAdapter?.profiles = profiles
        contentView.tableView.reloadData()
    }
}

// MARK: - ListViewDelegate

extension ListViewController: ListViewAdapterDelegate {
    func didTap(index: Int) {

        listViewPresenter?.selectedProfile(index: index)
    }
    
    func removed(profile: Profile) {

        listViewPresenter?.delete(profile: profile)
        contentView.tableView.reloadData()
    }
}
