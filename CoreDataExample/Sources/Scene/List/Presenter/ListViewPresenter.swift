//
//  ListViewPresenter.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 01.06.2022.
//

import Foundation

class ListViewPresenter: ListViewOutput {
    
    private var viewInput: ListViewInput?
    private var dataProvider: CoreDataProvider
    
    init(dataProvider: CoreDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func setViewInput(viewInput: ListViewInput?) {
        self.viewInput = viewInput
    }
    
    func addProfile(name: String) {
        dataProvider.saveProfile(name: name)
        guard let profiles = dataProvider.fetchData() else { return }
        viewInput?.update(with: profiles)
    }
    
    func delete(profile: Profile) {
        dataProvider.delete(profile: profile)
    }
    
    func getData() {
        guard let profiles = dataProvider.fetchData() else { return }
        viewInput?.update(with: profiles)
    }
    
    func selectedProfile(index: Int) {
        guard let profile = dataProvider.fetchData()?[index] else { return }

        viewInput?.openDetailView(for: profile)
    }
}
