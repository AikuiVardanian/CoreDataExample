//
//  ListViewOutput.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 01.06.2022.
//

import Foundation

protocol ListViewOutput {
    func addProfile(name: String)
    func getData()
    func delete(profile: Profile)
    func selectedProfile(index: Int)
}
