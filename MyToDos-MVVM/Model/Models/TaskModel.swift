//
//  TaskModel.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 07.04.2024.
//

import Foundation
import CoreData

struct TaskModel: Equatable {
    var id: String!
    var title: String!
    var icon: String!
    var done: Bool!
    var createdAt: Date!
}

extension TaskModel: EntityModelMapProtocol {
    typealias EntityType = Task

    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let task: Task = .init(context: context)
        task.id = id
        task.title = title
        task.icon = icon
        task.done = done
        task.createdAt = createdAt
        return task
    }

    static func mapFromEntity(_ entity: Task) -> Self {
        return .init(
            id: entity.id,
            title: entity.title,
            icon: entity.icon,
            done: entity.done,
            createdAt: entity.createdAt
        )
    }
}
