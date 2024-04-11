//
//  TaskListViewController.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

class TaskListViewController: UIViewController {
    private var taskListView: TaskListView!
    private var viewModel: TaskListViewModel!

    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupTaskListView()
    }

    private func setupTaskListView() {
        taskListView = TaskListView(viewModel: viewModel)
        self.view = taskListView
    }
}
