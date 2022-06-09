//
//  DetailViewPresenter.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import UIKit

class DetailViewPresenter: DetailViewOutput {    
    
    private var viewInput: DetailViewInput?
    private var dataProvider: CoreDataProvider?
    
    var profile: Profile?
    
    init(viewInput: DetailViewInput) {
        self.viewInput = viewInput
        dataProvider = CoreDataProvider()
    }
    
    func viewWasLoaded() {
        guard let profile = profile else { return }
        viewInput?.update(with: profile)
    }
    
    func updateProfileInDataBase() {
        guard let profile = profile,
              let viewInput = viewInput as? DetailViewController else { return }
        
        if let nameStackView = viewInput.contentView.nameStackView.arrangedSubviews.first as? UIStackView,
           let nameTextField = nameStackView.arrangedSubviews.last as? UITextField,
           let name = nameTextField.text {
            
            profile.name = name
        }
        
        if let birthdayStackView = viewInput.contentView.birthdayStackView.arrangedSubviews.first as? UIStackView,
           let birthdayTextField = birthdayStackView.arrangedSubviews.last as? UITextField,
           let birthday = birthdayTextField.text {
            
            profile.birthday = birthday
        }
        
        if let genderStackView = viewInput.contentView.genderStackView.arrangedSubviews.first as? UIStackView,
           let genderTextField = genderStackView.arrangedSubviews.last as? UITextField,
           let gender = genderTextField.text {
            
            profile.gender = gender
        }
        
        dataProvider?.updateProfile()
    }
}
