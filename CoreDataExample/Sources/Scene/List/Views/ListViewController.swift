//
//  ListViewController.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 04.05.2022.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var contentView = ListView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.title = "RT"
    }
}
