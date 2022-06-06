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
    var listViewOutput: ListViewOutput?
    var listViewPresenter = ListViewPresenter(dataProvider: CoreDataProvider())
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        listViewPresenter.setViewInput(viewInput: self)
        listViewOutput = listViewPresenter
        listViewOutput?.getData()
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
                  let presenter = listViewOutput else {return }
            
            presenter.addProfile(name: nameToSave)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func showViewController(destination: UIViewController) {
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension ListViewController: ListViewInput {
    func update(with profiles: [Profile]) {
        contentView.profiles = profiles
        contentView.reloadView()
    }
}
