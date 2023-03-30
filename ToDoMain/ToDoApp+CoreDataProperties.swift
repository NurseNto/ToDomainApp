//
//  ToDoApp+CoreDataProperties.swift
//  ToDoMain
//
//  Created by Nurse Ntombi Masango on 2022/09/06.
//
//

import Foundation
import CoreData


extension ToDoApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoApp> {
        return NSFetchRequest<ToDoApp>(entityName: "ToDoApp")
    }

    @NSManaged public var completedAt: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var isArchived: Bool
    @NSManaged public var name: String?
    @NSManaged public var category: Category?

}

extension ToDoApp : Identifiable {

}
