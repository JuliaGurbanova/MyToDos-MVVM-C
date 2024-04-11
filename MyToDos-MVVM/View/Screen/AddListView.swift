//
//  AddListView.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 10.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

class AddListView: UIView {
    private(set) var backButton = BackButton(frame: .zero)
    private(set) var pageTitle = PageLabel(title: "Add List")
    private(set) var titleLabel = FieldLabel(title: "Title")
    private(set) var titleTextField = UITextField()
    private(set) var iconLabel = FieldLabel(title: "Icon")
    private(set) var iconSelectorView = IconSelectorView(frame: .zero, iconColor: .mainBlue)
    private(set) var addListButton = MainButton(title: "Add List", color: .mainBlue)

    private let viewModel: AddListViewModel!
    private let disposeBag = DisposeBag()

    init(frame: CGRect = .zero, viewModel: AddListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        configureBackButton()
        configurePageTitleLabel()
        configureTitleLabel()
        configureTitleTextField()
        configureIconLabel()
        configureAddListButton()
        configureCollectionView()
        bindViewToModel(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddListView {
    func configureBackButton() {
        addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configurePageTitleLabel() {
        addSubview(pageTitle)

        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            pageTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            pageTitle.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            pageTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureTitleLabel() {
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    func configureTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.placeholder = "Add list title"
        titleTextField.textColor = .grayText
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Add list title",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.grayBackground])

        addSubview(titleTextField)

        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            titleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureIconLabel() {
        addSubview(iconLabel)

        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            iconLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }

    func configureAddListButton() {
        addSubview(addListButton)

        NSLayoutConstraint.activate([
            addListButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            addListButton.widthAnchor.constraint(equalToConstant: 150),
            addListButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configureCollectionView() {
        iconSelectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconSelectorView)

        NSLayoutConstraint.activate([
            iconSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconSelectorView.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 10),
            iconSelectorView.bottomAnchor.constraint(equalTo: addListButton.topAnchor, constant: -20)
        ])
    }

    func bindViewToModel(_ viewModel: AddListViewModel) {
        titleTextField.rx.text
            .map { !($0?.isEmpty)! }
            .bind(to: addListButton.rx.isEnabled)
            .disposed(by: disposeBag)

        titleTextField.rx.text
            .map { $0! }
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)

        addListButton.rx.tap
            .bind(to: viewModel.input.addList)
            .disposed(by: disposeBag)

        backButton.rx.tap
            .bind(to: viewModel.input.dismiss)
            .disposed(by: disposeBag)

        iconSelectorView.selectedIcon
            .bind(to: viewModel.input.icon)
            .disposed(by: disposeBag)
    }
}
