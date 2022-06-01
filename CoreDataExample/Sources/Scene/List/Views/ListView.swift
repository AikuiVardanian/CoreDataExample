//
//  ListView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit
import CoreData

final class ListView: UIView {
    
    let lcv = ListViewController()
    
    // MARK: - Properties
    
    lazy var tableView = UITableView(frame: .zero).then {
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
        $0.dataSource = self
        $0.delegate = self
    }
    
    var profiles: [NSManagedObject] = []
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Settings
    func setupHierarchy() {
        addSubview(tableView)
    }

    func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaInsets)
        }
    }
    
    func setupView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Profile")
        
        do {
            profiles = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func reloadView() {
        setupView()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        guard let profile = profiles[indexPath.row].value(forKey: "name") as? String else { return UITableViewCell() }
        
        cell.configureCell(with: profile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
                        
            let profile = profiles[indexPath.row]
            
            managedContext.delete(profile)
            profiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveContext()
        }
    }
    
    func saveContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let profile = profiles[indexPath.row].value(forKey: "name") as? String else { return }
        let destination = DetailView()
        
        destination.configureView(with: profile)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(destination, animated: true)
        //lcv.showViewController(destination: destination)
    }
}
