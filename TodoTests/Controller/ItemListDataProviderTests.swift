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
        
    
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(ItemCell.self, forCellReuseIdentifier: "ItemCell")
        sut.itemManager?.add(ToDoItem(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeue)
    }
}










