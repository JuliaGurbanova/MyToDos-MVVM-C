//
//  AddListViewController.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 10.04.2024.
//

import UIKit

class AddListViewController: UIViewController {
    private var addListView: AddListView!
    private var viewModel: AddListViewModel!

    init(viewModel: AddListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupAddListView()
    }

    private func setupAddListView() {
        addListView = AddListView(viewModel: viewModel)
        self.view = addListView
    }
}
