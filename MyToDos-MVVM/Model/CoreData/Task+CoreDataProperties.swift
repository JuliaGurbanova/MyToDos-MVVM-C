//
//  Task+CoreDataProperties.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 03.04.2024.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var done: Bool
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var list: TasksList?

}

extension Task : Identifiable {

}
