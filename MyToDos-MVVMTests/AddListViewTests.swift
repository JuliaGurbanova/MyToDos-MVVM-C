//
//  AddListViewTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest
@testable import MyToDos_MVVM

final class AddListViewTests: XCTestCase {
    var sut: AddListView!

    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let coordinator = MockAddListCoordinator()

    override func setUpWithError() throws {
        let viewModel = AddListViewModel(tasksListService: tasksListService, coordinator: coordinator)
        sut = AddListView(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiatesShouldBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.backButton)
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.iconLabel)
        XCTAssertNotNil(sut.iconSelectorView)
        XCTAssertNotNil(sut.addListButton)
    }

    func testTextField_whenTextFieldIsCreatedShouldBeEmpty() {
        XCTAssertEqual(sut.titleTextField.text, "")
    }

    func testAddListButton_whenThereIsNoTitleButtonShouldBeDisabled() {
        XCTAssertFalse(sut.addListButton.isEnabled)
    }

    func testAddListButton_whenThereIsTitleButtonShouldBeEnabled() {
        sut.titleTextField.insertText("Test Title")
        XCTAssertTrue(sut.addListButton.isEnabled)
    }
}
