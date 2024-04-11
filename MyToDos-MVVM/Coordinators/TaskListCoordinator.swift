//
//  TaskListCoordinator.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

protocol TaskListCoordinatorProtocol {
    func goToAddTask()
    func navigateBack()
}

class TaskListCoordinator: Coordinator, TaskListCoordinatorProtocol {
    var navigationController: UINavigationController
    var taskList: TasksListModel!

    init(navigationController: UINavigationController, taskList: TasksListModel) {
        self.navigationController = navigationController
        self.taskList = taskList
    }

    func start() {
        let viewModel = TaskListViewModel(
            tasksListModel: taskList,
            taskService: TaskService(),
            tasksListService: TasksListService(),
            coordinator: self
        )
        let taskListViewController = TaskListViewController(viewModel: viewModel)
        navigationController.pushViewController(taskListViewController, animated: true)
    }

    func goToAddTask() {
        let addTaskCoordinator = AddTaskCoordinator(navigationController: navigationController, tasksList: taskList)
        addTaskCoordinator.start()
    }

    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}
