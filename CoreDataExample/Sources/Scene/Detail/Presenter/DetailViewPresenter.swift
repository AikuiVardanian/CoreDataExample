//
//  DetailViewPresenter.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import Foundation

class DetailViewPresenter: DetailViewOutput {    
    private var viewInput: DetailViewInput?
    private var dataProvider: CoreDataProvider?
    
    var profile: Profile?
    
    init(viewInput: DetailViewInput) {
        self.viewInput = viewInput
        dataProvider = CoreDataProvider()
    }
    
    func setViewInput(viewInput: DetailViewInput?) {
        self.viewInput = viewInput
    }
    
    func reloadView() {
        guard let profile = profile else { return }

        viewInput?.update(with: profile)
    }
    
    func updateProfile() {
        guard let profile = profile, let viewInput = viewInput as? DetailViewController else { return }
        
        profile.name = viewInput.contentView.nameStackView.layer.name
        profile.birthday = viewInput.contentView.birthdayStackView.layer.name
        profile.gender = viewInput.contentView.genderStackView.layer.name
        
        dataProvider?.updateProfile()
    }
}
