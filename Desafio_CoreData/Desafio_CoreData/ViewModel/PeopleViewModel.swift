//
//  PeopleViewModel.swift
//  Desafio_CoreData
//
//  Created by Gui Feitosa on 12/11/21.
//

import Foundation
import UIKit

protocol PeopleViewModelDelegate {
    func errorAddPeople()
    func reloadData()
}

class PeopleViewModel {
    
    var people: [People] = []
    
    var delegate: PeopleViewModelDelegate?
    
    let context = ((UIApplication.shared.delegate)
                   as! AppDelegate)
        .persistentContainer
        .viewContext
    
    func loadData() {
        getListPeopleInCoreData()
        delegate?.reloadData()
    }
    func addPeople(name: String?, age: String?) {
        
        if checkIfTheFieldIsNull(name: name, age: age) {
            
            let age = convertStringAgeForInt16(strAge: age!)
            addPeopleInCoreData(name: name, age: age)
            
            delegate?.reloadData()
        } else {
            delegate?.errorAddPeople()
        }
    }
    
    func removePeople(name: String?, age: String?) {
        
        if checkIfTheFieldIsNull(name: name, age: age) {
            
            let age = convertStringAgeForInt16(strAge: age!)
            
            guard let people = findFirstPeopleWith(name: name!, age: age) else { return }
            
            removePeopleInCoreData(person: people)
            delegate?.reloadData()
        }
    }
    
    func removePeople(position: Int) {
        removePeopleInCoreData(person: people[position])
        delegate?.reloadData()
    }
    
    
    func checkIfTheFieldIsNull(name: String?, age: String?) -> Bool {
        
        if name == nil && age == nil {
            delegate?.errorAddPeople()
            return false
        }
        
        return true
    }
    
    func convertStringAgeForInt16(strAge: String) -> Int16 {
        
        guard let age = Int16(strAge) else {
            delegate?.errorAddPeople()
            return 0
        }
        return age
    }
    
    func numberOfPeopleOnTheList() -> Int {
        return people.count
    }
    
    func findFirstPeopleWith(name: String?, age: Int16) -> People? {
        
        for person in people {
            if person.name == name && person.age == age {
                return person
            }
        }
        return nil
    }
    
    // MARK: - CoreData
    
    func getListPeopleInCoreData() {
        do {
            people = try context.fetch(People.fetchRequest())
        } catch {
            
        }
    }
    
    func addPeopleInCoreData(name: String?, age: Int16) {
        let person: People = .init(context: context)
        person.name = name
        person.age = age
        
        saveContext()
        getListPeopleInCoreData()
    }
    
    func removePeopleInCoreData(person: People) {
        context.delete(person)
        saveContext()
        getListPeopleInCoreData()
    }
    
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            
        }
    }
}
