//
//  DetailViewPresenter.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import Foundation

class DetailViewPresenter: DetailViewOutput {
    
    private var viewInput: DetailViewInput?
    private var dataProvider: CoreDataProvider
    
    var profile: Profile?
    
    init(dataProvider: CoreDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func setViewInput(viewInput: DetailViewInput?) {
        self.viewInput = viewInput
    }
    
    func configureView(with profile: Profile) {
        viewInput?.update(with: profile)
    }
    
    func updateProfile(with profile: Profile) {
        dataProvider.updateProfile()
    }
    
    func reloadView() {
        guard let profile = profile else { return }

        viewInput?.update(with: profile)
    }
}
