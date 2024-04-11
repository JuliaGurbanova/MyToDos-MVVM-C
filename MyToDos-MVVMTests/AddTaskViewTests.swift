//
//  AddTaskViewTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest
@testable import MyToDos_MVVM

final class AddTaskViewTests: XCTestCase {
    var sut: AddTaskView!
    var taskList = TasksListModel(id: "12345-67890",
                                  title: "Test List",
                                  icon: "test.icon",
                                  tasks: [],
                                  createdAt: Date())

    let taskService = TaskService(coreDataManager: InMemoryCoreDataManager.shared)
    let coordinator = MockAddTaskCoordinator()

    override func setUpWithError() throws {
        let viewModel = AddTaskViewModel(tasksListModel: taskList, taskService: taskService, coordinator: coordinator)
        sut = AddTaskView(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiatedShouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.iconLabel)
        XCTAssertNotNil(sut.iconSelectorView)
        XCTAssertNotNil(sut.addTaskButton)
        XCTAssertNotNil(sut.titleLabel)
    }

    func testTextField_whenTextFieldIsCreatedShouldBeEmpty() {
        XCTAssertEqual(sut.titleTextField.text, "")
    }

    func testAddTaskButton_whenThereIsNoTitleButtonShouldBeDisabled() {
        XCTAssertFalse(sut.addTaskButton.isEnabled)
    }

    func testAddTaskButton_whenThereIsTitleButtonShouldBeEnabled() {
        sut.titleTextField.insertText("Test Title")
        XCTAssertTrue(sut.addTaskButton.isEnabled)
    }
}
