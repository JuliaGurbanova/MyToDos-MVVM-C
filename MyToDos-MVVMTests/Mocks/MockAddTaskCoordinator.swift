//
//  MockAddTaskCoordinator.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import Foundation
@testable import MyToDos_MVVM

class MockAddTaskCoordinator: AddTaskCoordinatorProtocol {
    var dismissView = 0

    func dismiss() {
        dismissView += 1
    }
}
