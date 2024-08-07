//
//  Item+CoreDataProperties.swift
//  TaskOrganizer
//
//  Created by Vitali Schumarov on 07.08.2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var todo: String?
    @NSManaged public var done: Bool
    @NSManaged public var relationshiopToGroup: Group?

}
