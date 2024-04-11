//
//  MockTaskListCoordinator.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import Foundation
@testable import MyToDos_MVVM

class MockTaskListCoordinator: TaskListCoordinatorProtocol {
    var addedTask = 0
    var navigatedBack = 0

    func goToAddTask() {
        addedTask += 1
    }

    func navigateBack() {
        navigatedBack += 1
    }
}
