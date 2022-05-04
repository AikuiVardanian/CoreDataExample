//
//  ListView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit

final class ListView: UIView {
    
    // MARK: - Properties
    lazy var nameTextField = UITextField()
    lazy var saveButton = UIButton()
    lazy var tableView = UITableView()
    
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
    func setupHierarchy() { }

    func setupLayout() { }
    
    func setupView() {
        backgroundColor = .red
    }
}
