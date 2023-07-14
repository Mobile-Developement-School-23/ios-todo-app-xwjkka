//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Olesya Khurmuzakiy on 14.07.2023.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: String?
    @NSManaged public var text: String?
    @NSManaged public var importance: String?
    @NSManaged public var done: Bool
    @NSManaged public var deadline: Date?
    @NSManaged public var created: Date?
    @NSManaged public var changed: Date?

}
