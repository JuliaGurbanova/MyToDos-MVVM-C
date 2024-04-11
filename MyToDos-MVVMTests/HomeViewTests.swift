//
//  HomeViewTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest

@testable import MyToDos_MVVM

final class HomeViewTests: XCTestCase {
    var sut: HomeView!
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let mockHomeCoordinator = MockHomeCoordinator()

    override func setUpWithError() throws {
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        let viewModel = HomeViewModel(tasksListService: tasksListService, coordinator: mockHomeCoordinator)
        sut = HomeView(viewModel: viewModel)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testViewLoaded_whenViewIsInstantiatedShoulBeComponents() {
        XCTAssertNotNil(sut.pageTitle)
        XCTAssertNotNil(sut.addListButton)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.emptyState)
    }

    func testEmptyState_whenModelHasZeroListsShouldBeEmptyState() {
        XCTAssertFalse(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasAListShouldNotBeEmptyState() {
        addListToDataBase()
        XCTAssertTrue(sut.emptyState.isHidden)
    }

    func testTableView_whenModelHasAListShouldBeOneRow() {
        addListToDataBase()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }

    func testTableView_whenModelHasAListShouldBeACellAtIndexPath() {
        addListToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertNotNil(cell)
    }

    func testTableView_whenListIsDeletedShouldBeNoneOnModel() {
        addListToDataBase()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.dataSource?.tableView?(sut.tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertTrue(tasksListService.fetchLists().isEmpty)
    }
}

extension HomeViewTests {
    func addListToDataBase() {
        let taskList = TasksListModel(id: "12345-67890",
                                      title: "Test List",
                                      icon: "test.icon",
                                      tasks: [TaskModel](),
                                      createdAt: Date())
        tasksListService.saveTasksList(taskList)
        let viewModel = HomeViewModel(tasksListService: tasksListService, coordinator: mockHomeCoordinator)
        sut = HomeView(viewModel: viewModel)
    }
}
