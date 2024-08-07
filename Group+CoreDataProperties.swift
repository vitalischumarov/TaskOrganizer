//
//  Group+CoreDataProperties.swift
//  TaskOrganizer
//
//  Created by Vitali Schumarov on 07.08.2024.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var title: String?
    @NSManaged public var relationshipToItem: NSSet?

}

// MARK: Generated accessors for relationshipToItem
extension Group {

    @objc(addRelationshipToItemObject:)
    @NSManaged public func addToRelationshipToItem(_ value: Item)

    @objc(removeRelationshipToItemObject:)
    @NSManaged public func removeFromRelationshipToItem(_ value: Item)

    @objc(addRelationshipToItem:)
    @NSManaged public func addToRelationshipToItem(_ values: NSSet)

    @objc(removeRelationshipToItem:)
    @NSManaged public func removeFromRelationshipToItem(_ values: NSSet)

}

extension Group : Identifiable {

}
