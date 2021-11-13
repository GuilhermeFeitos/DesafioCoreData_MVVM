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
    
    private let service = CoreDataService()
    
    func loadData() {
        people = service.getListPeopleInCoreData()
        delegate?.reloadData()
    }
    func addPeople(name: String?, age: String?) {
        
        if checkIfTheFieldIsNull(name: name, age: age) {
            
            let age = convertStringAgeForInt16(strAge: age!)
            people = service.addPeopleInCoreData(name: name, age: age)
            
            delegate?.reloadData()
        } else {
            delegate?.errorAddPeople()
        }
    }
    
    func removePeople(name: String?, age: String?) {
        
        if checkIfTheFieldIsNull(name: name, age: age) {
            
            let age = convertStringAgeForInt16(strAge: age!)
            
            guard let person = findFirstPeopleWith(name: name!, age: age) else { return }
            
            people = service.removePeopleInCoreData(person: person)
            delegate?.reloadData()
        }
    }
    
    func removePeople(person: People) {
        people = service.removePeopleInCoreData(person: person)
    }
    
    
    func checkIfTheFieldIsNull(name: String?, age: String?) -> Bool {
        
        if let name = name, name.isEmpty {
            delegate?.errorAddPeople()
            return false
        }
        
        if let age = age, age.isEmpty {
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
}
