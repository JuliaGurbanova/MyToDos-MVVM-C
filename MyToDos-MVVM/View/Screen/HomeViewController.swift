//
//  HomeViewController.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 07.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeView: HomeView!
    private var viewModel: HomeViewModel!

    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupHomeView()
    }

    private func setupHomeView() {
        homeView = HomeView(viewModel: viewModel)
        self.view = homeView
    }
}
