//
//  HomeCoordinator.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func showSelectedList(_ list: TasksListModel)
    func goToAddList()
}

class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = HomeViewModel(tasksListService: TasksListService(), coordinator: self)
        navigationController.pushViewController(HomeViewController(viewModel: viewModel), animated: true)
    }

    func showSelectedList(_ list: TasksListModel) {
        let taskListCoordinator = TaskListCoordinator(navigationController: navigationController, taskList: list)
        taskListCoordinator.start()
    }

    func goToAddList() {
        let addListCoordinator = AddListCoordinator(navigationController: navigationController)
        addListCoordinator.start()
    }
}
