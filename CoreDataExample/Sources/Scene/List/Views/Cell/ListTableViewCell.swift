//
//  ListTableViewCell.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    
    // MARK: - Configure cell
    
    public func configureCell(with model: String) {
        titleLabel.text = model
    }
    
    // MARK: - Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Settings

    func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    func setupHierarchy() {
        addSubview(titleLabel)
    }

    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.left.top.equalTo(16)
            $0.right.bottom.equalTo(-16)
        }
    }
    
    func setupView() {
    }
}
