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
    var profiles: [NSManagedObject] = []
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
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
                  let nameToSave = textFields.text else { return }
            
            self.save(name: nameToSave)
            contentView.reloadView()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext)!
        
        let profile = NSManagedObject(entity: entity, insertInto: managedContext)
        
        profile.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            profiles.append(profile)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
}
