//
//  ListView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit

final class ListView: UIView {
        
    // MARK: - Properties
    
    var viewAdapter = ListViewAdapter()
    
    lazy var tableView = UITableView(frame: .zero).then {
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: viewAdapter.identifier)
        $0.dataSource = viewAdapter
        $0.delegate = viewAdapter.self
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupHierarchy()
        setupLayout()
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
}
