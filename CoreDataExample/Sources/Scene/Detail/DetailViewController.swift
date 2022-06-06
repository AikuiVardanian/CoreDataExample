//
//  DetailViewController.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var contentView = DetailView()
    var detailViewOutput: DetailViewOutput?
    var detailViewPresenter = DetailViewPresenter(dataProvider: CoreDataProvider())
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewPresenter.setViewInput(viewInput: self)
        detailViewOutput = detailViewPresenter
        detailViewOutput?.reloadView()
    }
}

// MARK: - Extension

extension DetailViewController: DetailViewInput {
    func update(with profile: Profile) {
        contentView.profile = profile
    }
}
