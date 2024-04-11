//
//  AddListCoordinator.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

protocol AddListCoordinatorProtocol {
    func navigateBack()
}

class AddListCoordinator: Coordinator, AddListCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = AddListViewModel(tasksListService: TasksListService(), coordinator: self)
        navigationController.pushViewController(AddListViewController(viewModel: viewModel), animated: true)
    }

    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
