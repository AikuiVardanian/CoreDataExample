//
//  DetailViewController.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var contentView = DetailView()
    var detailViewOutput: DetailViewOutput?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailViewOutput?.reloadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewOutput?.reloadView()
    }
}

// MARK: - Extension

extension DetailViewController: DetailViewInput {
    func update(with profile: Profile) {
        contentView.profile = profile
    }
}
