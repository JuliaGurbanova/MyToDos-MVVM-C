//
//  MockAddListCoordinator.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import Foundation
@testable import MyToDos_MVVM

class MockAddListCoordinator: AddListCoordinatorProtocol {
    var navigatedBack = 0

    func navigateBack() {
        navigatedBack += 1
    }
}
