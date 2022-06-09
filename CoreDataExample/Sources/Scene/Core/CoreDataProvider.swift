//
//  CoreDataProvider.swift
//  CoreDataExample
//
//  Created by Aikui Vardanian on 01.06.2022.
//

import UIKit
import CoreData

protocol CoreDataProviderType {
    func fetchData() -> [Profile]?
    func saveProfile(name: String)
    func delete(profile: Profile)
    func updateProfile()
}

final class CoreDataProvider: CoreDataProviderType {
    private var managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    func fetchData() -> [Profile]? {
        try? managedContext.fetch(Profile.fetchRequest())
    }
    
    func saveProfile(name: String) {
        let profile = Profile(context: managedContext)
        profile.name = name
        profile.birthday = nil
        profile.gender = nil
        
        try? managedContext.save()
    }
    
    func delete(profile: Profile) {
        managedContext.delete(profile)
        try? managedContext.save()
    }
    
    func updateProfile() {
        try? managedContext.save()
    }
}

extension CoreDataProvider {
    enum Strings {
        static let modelName = "Profile"
    }
}
