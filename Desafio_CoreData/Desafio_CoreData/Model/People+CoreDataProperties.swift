//
//  People+CoreDataProperties.swift
//  Desafio_CoreData
//
//  Created by Gui Feitosa on 12/11/21.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}

extension People : Identifiable {

}
