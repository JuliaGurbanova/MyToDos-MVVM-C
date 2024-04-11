//
//  MockHomeCoordinator.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import Foundation
@testable import MyToDos_MVVM

class MockHomeCoordinator: HomeCoordinatorProtocol {
    var addedList = 0
    var selectedList = TasksListModel()

    func showSelectedList(_ list: TasksListModel) {
        selectedList = list
    }

    func goToAddList() {
        addedList += 1
    }
}
