//
//  DetailViewOutput.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import Foundation

protocol DetailViewOutput {
    func configureView(with profile: Profile)
    func updateProfile(with profile: Profile)
    func reloadView()
}
