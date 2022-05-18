//
//  ListView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit

final class ListView: UIView {
    
    // MARK: - Properties
    private lazy var nameTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.autocapitalizationType = .none
        $0.tintColor = .systemGray5
    }
    
    private lazy var saveButton = UIButton(type: .system).then {
        $0.setTitle("Add", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .systemBlue
    }
    
    private lazy var tableView = UITableView(frame: .zero).then {
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: "Cell")
        $0.dataSource = self
        $0.delegate = self
    }
    
    var person: [Profile]? = [Profile(name: "kjb")]
    
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
        backgroundColor = .red
    }
}

// MARK: - UITableViewDataSource

extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        guard let profile = person?[indexPath.row] else { return UITableViewCell() }
        
        cell.configureCell(with: profile)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListView: UITableViewDelegate {
    
}
