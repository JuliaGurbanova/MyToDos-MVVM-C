//
//  AddListViewModelTests.swift
//  MyToDos-MVVMTests
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import XCTest
import RxSwift
import RxTest
@testable import MyToDos_MVVM

final class AddListViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var viewModel:AddListViewModel!
    var testScheduler: TestScheduler!
    let coordinator = MockAddListCoordinator()

    let tasksListService = TasksListService(coreDataManager: InMemoryCoreDataManager.shared)

    override func setUpWithError() throws {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        tasksListService.fetchLists().forEach {
            tasksListService.deleteList($0)
        }
        viewModel = AddListViewModel(tasksListService: tasksListService, coordinator: coordinator)
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

    func testAddList_whenAddListIsCalledDismissShouldBeCalled() {
        testScheduler.createColdObservable([.next(10, "test.icon")])
            .bind(to: viewModel.input.icon)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(20, "test.title")])
            .bind(to: viewModel.input.title)
            .disposed(by: disposeBag)

        testScheduler.createColdObservable([.next(30, ())])
            .bind(to: viewModel.input.addList)
            .disposed(by: disposeBag)
        testScheduler.start()

        XCTAssertEqual(viewModel.list.icon, "test.icon")
        XCTAssertEqual(viewModel.list.title, "test.title")
        XCTAssertEqual(coordinator.navigatedBack, 1)
    }
}
