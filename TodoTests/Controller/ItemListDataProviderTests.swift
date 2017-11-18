//
//  ItemListDataProviderTests.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/17/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest

@testable import Todo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_NumberOfSection_isTwo() {
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_NumberOfRows_InFirstSection_IsToDoCount() {
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.add(ToDoItem(title:"Bar"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
    }
    
    func test_NumberOfRows_InSecondSection_IsToDoneCount() {
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        sut.itemManager?.add(ToDoItem(title: "Bar"))
        
        sut.itemManager?.checkItem(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        
         XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func test_CellForRow_ReturnItemCell() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
}

extension ItemListDataProviderTests {
    
    class MockTableView: UITableView {
        
        var cellGotDequeue = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            
            cellGotDequeue = true
            return super.dequeueReusableCell(withIdentifier:identifier, for:indexPath)
        }
        
        class func mockTableView(withDataSource datasource: UITableViewDataSource) -> MockTableView {
            
            let mockTableView = MockTableView(frame: CGRect(x:0, y:0,width:320,height:480), style: .plain)
             mockTableView.dataSource = datasource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            return mockTableView
        }
        
    
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeue)
    }
}

extension ItemListDataProviderTests {
    
    class MockItemCell: ItemCell {
        
        var catchedItem:ToDoItem?
        
        override func configCell(with item: ToDoItem, checked: Bool = false) {
            
            catchedItem = item
        }
    }
    
    func test_CellForRow_CallsConfigCell() {
        
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        let item = ToDoItem(title: "Foo")
        sut.itemManager?.add(item)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        cell.configCell(with: item)
        
        XCTAssertEqual(cell.catchedItem, item)
    }
    
    func test_CellForRow_InSectionTwo_CallsConfigCell() {
        
       let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        let second = ToDoItem(title: "Bar")
        sut.itemManager?.add(second)
        
        sut.itemManager?.checkItem(at: 1)
        mockTableView.reloadData()
        
         let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        
        XCTAssertEqual(cell.catchedItem, second)
    }
}

extension ItemListDataProviderTests {
    
    func test_DeleteButton_InFirstSection_ShowTitleCheck() {
        
        let deleteButtonTitle = tableView.delegate?.tableView!(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func test_DeleteButton_InSecondSection_ShowTitleUnCheck() {
        
        let deleteButtonTitle = tableView.delegate?.tableView!(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
}

extension ItemListDataProviderTests {
    
    func test_CheckingAnItem_CheckItInTheItemManager() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
        XCTAssertEqual(sut.itemManager?.doneCount, 1)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func test_UncheckingAnItem_UncheckItInTheItemManager() {
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        sut.itemManager?.checkItem(at: 0)
        tableView.reloadData()
        tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.itemManager?.toDoCount, 1)
        XCTAssertEqual(sut.itemManager?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 0)
        
    }
}








