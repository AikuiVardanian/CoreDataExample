//
//  DetailView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 31.05.2022.
//

import UIKit

protocol DetailViewDelegate {
    func updateProfile()
}

final class DetailView: UIView {
    
    var profile: Profile?
    var delegate: DetailViewDelegate?
    
    // MARK: - Properties
    private lazy var contentScrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var profilePictureImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.circle")
    }
    
    private lazy var parentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = Metrics.parentStackViewSpacing
    }
    
    private lazy var personInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .top
        $0.spacing = Metrics.profileInfoStackViewSpacing
    }
    
    lazy var nameStackView = createStackView(iconName: Images.person, description: "Name")
    lazy var birthdayStackView = createStackView(iconName: Images.birthday, description: "Birthday")
    lazy var genderStackView = createStackView(iconName: Images.person, description: "Gender")
    
    private lazy var saveButton = UIButton().then {
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = .systemFont(ofSize: Metrics.saveButtonFontSize, weight: .bold)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(updateProfile), for: .touchUpInside)
    }
    
    // MARK: - func createStackView
    
    private func createStackView(iconName: String, description: String) -> UIStackView {
        let descriptionTextField = UITextField().then {
            $0.font = .systemFont(ofSize: Metrics.descriptionTextFiledFontSize)
            $0.placeholder = description
        }
        
        let iconImageView = UIImageView().then {
            $0.image = UIImage(systemName: iconName)
        }
        
        let liner = UIView().then {
            $0.backgroundColor = .systemGray5
        }
        
        let topStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = Metrics.topStackViewSpacing
        }
        
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = Metrics.itemStackViewSpacing
        }
        
        descriptionTextField.delegate = self
        
        topStackView.addArrangedSubview(iconImageView)
        topStackView.addArrangedSubview(descriptionTextField)
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(liner)
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(Metrics.iconImageSize)
        }
        
        descriptionTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(Metrics.descriptionTextFiledWidthMult)
        }
        
        liner.snp.makeConstraints {
            $0.left.equalTo(topStackView)
            $0.right.equalTo(topStackView)
            $0.height.equalTo(Metrics.separatorHeight)
        }
        
        return stackView
    }
    
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
        addSubview(contentScrollView)
        
        contentScrollView.addSubview(parentStackView)
        contentScrollView.addSubview(saveButton)
        
        parentStackView.addArrangedSubview(profilePictureImageView)
        parentStackView.addArrangedSubview(personInfoStackView)
        
        personInfoStackView.addArrangedSubview(nameStackView)
        personInfoStackView.addArrangedSubview(birthdayStackView)
        personInfoStackView.addArrangedSubview(genderStackView)
    }
    
    func setupLayout() {
        contentScrollView.snp.makeConstraints {
            $0.left.top.right.bottom.equalTo(self)
        }
        
        parentStackView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(Metrics.parentStackViewTopOffset)
        }
        
        profilePictureImageView.snp.makeConstraints {
            $0.width.height.equalTo(Metrics.profilePictureSize)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(parentStackView).offset(Metrics.saveButtonBottomOffset)
            $0.width.equalTo(self).multipliedBy(Metrics.saveButtonWidthMult)
            $0.height.equalTo(Metrics.saveButtonHeight)
        }
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
    // MARK: - Update view
    
    func reloadView() {
        if let topStackView = nameStackView.arrangedSubviews.first as? UIStackView,
           let nameTextField = topStackView.arrangedSubviews.last as? UITextField,
           let name = profile?.name {
            
            nameTextField.text = name
        }
        
        if let topStackView = birthdayStackView.arrangedSubviews.first as? UIStackView,
           let birthdayTextField = topStackView.arrangedSubviews.last as? UITextField,
           let birthday = profile?.birthday {
            
            birthdayTextField.text = birthday
        }
        
        if let topStackView = genderStackView.arrangedSubviews.first as? UIStackView,
           let genderTextField = topStackView.arrangedSubviews.last as? UITextField,
           let gender = profile?.gender {
            
            genderTextField.text = gender
        }
    }
    
    @objc func updateProfile() {
        delegate?.updateProfile()
    }
}

// MARK: - Constants

extension DetailView {
    enum Metrics {
        static let parentStackViewTopOffset: CGFloat = 88
        static let parentStackViewSpacing: CGFloat = 44
        
        static let profilePictureSize: CGFloat = 120
        
        static let profileInfoStackViewSpacing: CGFloat = 32
        
        static let itemStackViewSpacing: CGFloat = 4
        
        static let topStackViewSpacing: CGFloat = 16
        
        static let iconImageSize: CGFloat = 44
        static let descriptionTextFiledWidthMult: CGFloat = 0.8
        static let descriptionTextFiledFontSize: CGFloat = 20
        static let separatorHeight: CGFloat = 2
        
        static let saveButtonFontSize: CGFloat = 20
        static let saveButtonBottomOffset: CGFloat = 88
        static let saveButtonWidthMult: CGFloat = 0.4
        static let saveButtonHeight: CGFloat = 44
    }
    
    enum Images {
        static let person = "person.fill"
        static let birthday = "calendar"
    }
}

// MARK: - TextField Delegate

extension DetailView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let topStackView = nameStackView.arrangedSubviews.first as? UIStackView,
           let nameTextField = topStackView.arrangedSubviews.last as? UITextField {
            
            nameTextField.endEditing(true)
        }
        
        if let topStackView = birthdayStackView.arrangedSubviews.first as? UIStackView,
           let birthdayTextField = topStackView.arrangedSubviews.last as? UITextField {
            
            birthdayTextField.endEditing(true)
        }
        
        if let topStackView = genderStackView.arrangedSubviews.first as? UIStackView,
           let genderTextField = topStackView.arrangedSubviews.last as? UITextField {
            
            genderTextField.endEditing(true)
        }
        
        return true
    }
}
