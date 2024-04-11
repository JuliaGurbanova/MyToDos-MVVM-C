//
//  AddTaskCoordinator.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

protocol AddTaskCoordinatorProtocol {
    func dismiss()
}

class AddTaskCoordinator: Coordinator, AddTaskCoordinatorProtocol {
    var navigationController: UINavigationController
    var tasksList: TasksListModel!

    init(navigationController: UINavigationController, tasksList: TasksListModel!) {
        self.navigationController = navigationController
        self.tasksList = tasksList
    }

    func start() {
        let viewModel = AddTaskViewModel(tasksListModel: tasksList, taskService: TaskService(), coordinator: self)
        navigationController.present(AddTaskViewController(viewModel: viewModel), animated: true)
    }

    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
