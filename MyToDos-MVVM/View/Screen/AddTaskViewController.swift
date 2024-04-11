//
//  AddTaskViewController.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

class AddTaskViewController: UIViewController {
    private var addTaskView: AddTaskView!
    private var viewModel: AddTaskViewModel!

    init(viewModel: AddTaskViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupAddTaskView()
    }

    private func setupAddTaskView() {
        addTaskView = AddTaskView(viewModel: viewModel)
        self.view = addTaskView
    }
}
