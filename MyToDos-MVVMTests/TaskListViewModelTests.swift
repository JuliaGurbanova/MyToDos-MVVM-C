//
//  TaskListViewModelTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest
import RxSwift
import RxTest
@testable import MyToDos_MVVM

final class TaskListViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var viewModel: TaskListViewModel!
    var testScheduler: TestScheduler!
    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)
    let taskService = TaskService(coreDataManager: InMemoryCoreDataManager.shared)
    let coordinator = MockTaskListCoordinator()
    var taskList = TasksListModel(
        id: "12345-67890",
        title: "Test List",
        icon: "test.icon",
        tasks: [TaskModel](),
        createdAt: Date()
    )
    var task = TaskModel(
        id: "67890-12345",
        title: "Test Task",
        icon: "test.icon",
        done: true,
        createdAt: Date()
    )

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        viewModel = TaskListViewModel(
            tasksListModel: taskList,
            taskService: taskService,
            tasksListService: tasksListService,
            coordinator: coordinator
        )
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        viewModel = nil
        testScheduler = nil
        tasksListService.fetchLists().forEach { tasksListService.deleteList($0) }
        super.tearDown()
    }

    func testEmptyState_whenThereIsNoTaskShouldShowEmptyState() {
        let hideEmptyState = testScheduler.createObserver(Bool.self)
        tasksListService.saveTasksList(taskList)

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
        taskService.saveTask(task, in: taskList)

        viewModel.output.hideEmptyState
            .drive(hideEmptyState)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(hideEmptyState.events, [.next(0, false), .next(10, true)])
    }

    func testRemoveTaskAtIndex_whenAddedOneTaskShouldBeEmptyModelOnDeleteTask() {
        let tasks = testScheduler.createObserver([TaskModel].self)
        tasksListService.saveTasksList(taskList)
        taskService.saveTask(task, in: taskList)

        viewModel.output.tasks
            .drive(tasks)
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

        XCTAssertEqual(tasks.events, [.next(0, []), .next(10, [task]), .next(30, []), .next(30, [])])
    }

    func testUpdateTaskAtIndex_whenSelectATaskShouldReturnOneList() {
        let doneStatus = testScheduler.createObserver(Bool.self)
        tasksListService.saveTasksList(taskList)
        taskService.saveTask(task, in: taskList)

        viewModel.output.tasks
            .map { $0.first?.done ?? false }
            .drive(doneStatus)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(10, IndexPath(row: 0, section: 0))])
            .bind(to: viewModel.input.updateRow)
            .disposed(by: disposeBag)

        testScheduler.start()

        XCTAssertEqual(doneStatus.events, [.next(0, false), .next(10, true)])
    }

    func testAddTaskButton_whenSelectAddTaskButtonShouldNavigate() {
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.addTask)
            .disposed(by: disposeBag)
        testScheduler.start()
        XCTAssertEqual(coordinator.addedTask, 1)
    }

    func testDismissView_whenBackButtonIsTappedShouldDismiss() {
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.dismiss)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(coordinator.navigatedBack, 1)
    }
}
