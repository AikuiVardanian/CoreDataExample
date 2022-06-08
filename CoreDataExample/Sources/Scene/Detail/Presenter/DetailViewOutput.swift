//
//  DetailViewOutput.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 06.06.2022.
//

import Foundation

protocol DetailViewOutput {
    var profile: Profile? { get set }
    
    func reloadView()
    func updateProfile()
}
