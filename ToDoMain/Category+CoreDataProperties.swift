//
//  Category+CoreDataProperties.swift
//  ToDoMain
//
//  Created by Nurse Ntombi Masango on 2022/09/06.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?
    @NSManaged public var toDoTasks: NSOrderedSet?

}

// MARK: Generated accessors for toDoTasks
extension Category {

    @objc(insertObject:inToDoTasksAtIndex:)
    @NSManaged public func insertIntoToDoTasks(_ value: ToDoApp, at idx: Int)

    @objc(removeObjectFromToDoTasksAtIndex:)
    @NSManaged public func removeFromToDoTasks(at idx: Int)

    @objc(insertToDoTasks:atIndexes:)
    @NSManaged public func insertIntoToDoTasks(_ values: [ToDoApp], at indexes: NSIndexSet)

    @objc(removeToDoTasksAtIndexes:)
    @NSManaged public func removeFromToDoTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInToDoTasksAtIndex:withObject:)
    @NSManaged public func replaceToDoTasks(at idx: Int, with value: ToDoApp)

    @objc(replaceToDoTasksAtIndexes:withToDoTasks:)
    @NSManaged public func replaceToDoTasks(at indexes: NSIndexSet, with values: [ToDoApp])

    @objc(addToDoTasksObject:)
    @NSManaged public func addToToDoTasks(_ value: ToDoApp)

    @objc(removeToDoTasksObject:)
    @NSManaged public func removeFromToDoTasks(_ value: ToDoApp)

    @objc(addToDoTasks:)
    @NSManaged public func addToToDoTasks(_ values: NSOrderedSet)

    @objc(removeToDoTasks:)
    @NSManaged public func removeFromToDoTasks(_ values: NSOrderedSet)

}

extension Category : Identifiable {

}
