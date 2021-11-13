//
//  CoreDataService.swift
//  Desafio_CoreData
//
//  Created by Gui Feitosa on 12/11/21.
//

import Foundation
import UIKit

class CoreDataService {
    
    private var people: [People] = []
    private let context = ((UIApplication.shared.delegate)
                   as! AppDelegate)
        .persistentContainer
        .viewContext
    
    func getListPeopleInCoreData()-> [People] {
        do {
            people = try context.fetch(People.fetchRequest())
            return people
        } catch {
            
        }
        
        return []
    }
    
   func addPeopleInCoreData(name: String?, age: Int16) ->[People] {
        let person: People = .init(context: context)
        person.name = name
        person.age = age
        
        saveContext()
        return getListPeopleInCoreData()
    }
    
    func removePeopleInCoreData(person: People) ->[People] {
        context.delete(person)
        saveContext()
        return getListPeopleInCoreData()
    }
    
    
   private func saveContext() {
        do {
            try context.save()
        } catch {
            
        }
    }
}

