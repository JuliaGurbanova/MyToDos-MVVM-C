//
//  HomeViewModelTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest
import RxSwift
import RxTest

@testable import MyToDos_MVVM

final class HomeViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var viewModel: HomeViewModel!
    var testScheduler: TestScheduler!

    let coordinator = MockHomeCoordinator()
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let taskList = TasksListModel(
        id: "12345-67890",
        title: "Test List",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach {
            tasksListService.deleteList($0)
        }
        viewModel = HomeViewModel(tasksListService: tasksListService, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        tasksListService.fetchLists().forEach {
            tasksListService.deleteList($0)
        }
        super.tearDown()
    }

    func testEmptyState_whenThereIsNoListShouldShowEmptyState() {
        let hideEmptyState = testScheduler.createObserver(Bool.self)

        viewModel.output.hideEmptyState
            .drive(hideEmptyState)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(hideEmptyState.events, [.next(0, false), .next(10, false)])
    }

    func testEmptyState_whenAddOneListShouldHideEmptyState() {
        let hideEmptyState = testScheduler.createObserver(Bool.self)
        tasksListService.saveTasksList(taskList)

        viewModel.output.hideEmptyState
            .drive(hideEmptyState)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(hideEmptyState.events, [.next(0, false), .next(10, true)])
    }

    func testRemoveListAtIndex_whenAddedOneListShouldBeEmptyModelOnDeleteList() {
        let lists = testScheduler.createObserver([TasksListModel].self)
        tasksListService.saveTasksList(taskList)

        viewModel.output.lists
            .drive(lists)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(20, IndexPath(row: 0, section: 0))])
            .bind(to: viewModel.input.deleteRow)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(30, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(lists.events, [.next(0, []), .next(10, [taskList]), .next(30, []), .next(30, [])])
    }

    func testSelectListAtIndex_whenSelectAListShouldReturnOneList() {
        let selectedList = testScheduler.createObserver(TasksListModel.self)
        tasksListService.saveTasksList(taskList)

        viewModel.output.selectedList
            .drive(selectedList)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(20, IndexPath(row: 0, section: 0))])
            .bind(to: viewModel.input.selectRow)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(coordinator.selectedList, taskList)
    }

    func testAddListButton_whenAddListButtonIsSelectedShouldNavigate() {
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.addList)
            .disposed(by: disposeBag)
        testScheduler.start()
        XCTAssertEqual(coordinator.addedList, 1)
    }
}
