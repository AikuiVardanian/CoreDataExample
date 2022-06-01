//
//  DetailView.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 31.05.2022.
//

import UIKit

final class DetailView: UIViewController {
    
    func configureView(with name: String) {
        self.name = name
    }
    
    private var name: String?
    
    // MARK: - Properties
    private lazy var profilePictureImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.circle")
    }
    
    private lazy var parentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 44
    }
    
    private lazy var personInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .top
        $0.spacing = 32
    }
    
    private lazy var nameStackView = createStackView(iconName: Images.person, description: name ?? "Name")
    private lazy var birthdayStackView = createStackView(iconName: Images.birthday, description: "Birthday")
    private lazy var genderStackView = createStackView(iconName: Images.person, description: "Gender")
    
    private lazy var saveButton = UIButton().then {
        $0.setTitle("Save", for: .normal)
        $0.tintColor = .white
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = .systemBlue
    }
    
    // MARK: - func createStackView
    
    private func createStackView(iconName: String, description: String) -> UIStackView {
        let descriptionTextField = UITextField().then {
            $0.font = .systemFont(ofSize: 20)
            $0.placeholder = description
            $0.text = description
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
            $0.spacing = 16
        }
        
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 4
        }
        
        topStackView.addArrangedSubview(iconImageView)
        topStackView.addArrangedSubview(descriptionTextField)
        
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(liner)
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(44)
        }
        
        descriptionTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        liner.snp.makeConstraints {
            $0.left.equalTo(topStackView)
            $0.right.equalTo(topStackView)
            $0.height.equalTo(2)
        }
        
        return stackView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    func setupHierarchy() {
        view.addSubview(parentStackView)
        view.addSubview(saveButton)
        
        parentStackView.addArrangedSubview(profilePictureImageView)
        parentStackView.addArrangedSubview(personInfoStackView)
        
        personInfoStackView.addArrangedSubview(nameStackView)
        personInfoStackView.addArrangedSubview(birthdayStackView)
        personInfoStackView.addArrangedSubview(genderStackView)
    }
    
    func setupLayout() {
        parentStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(88)
        }
        
        profilePictureImageView.snp.makeConstraints {
            $0.width.height.equalTo(120)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.bottom.equalTo(parentStackView).offset(88)
            $0.width.equalTo(view).multipliedBy(0.4)
            $0.height.equalTo(44)
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
}

// MARK: - Constants

extension DetailView {
    enum Metrics {
        
    }
    
    enum Images {
        static let person = "person.fill"
        static let birthday = "calendar"
    }
}
