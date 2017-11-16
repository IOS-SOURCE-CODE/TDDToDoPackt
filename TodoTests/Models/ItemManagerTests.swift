//
//  ItemManagerTests.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/16/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest

@testable import Todo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        
        sut = ItemManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ToDoCount_Initially_IsZero() {
        
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func test_DoneCount_Initially_IsZero() {
        XCTAssertEqual(sut.doneCount, 0)
    }
    
    func test_AddItem_IncreasesToDoCountToOne() {
        sut.add(ToDoItem(title: ""))
        XCTAssertEqual(sut.toDoCount, 1)
    }
    
    func test_ItemAt_AfterAddingItem_ReturnThatItem() {
        
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        let returnItem = sut.item(at: 0)
        XCTAssertEqual(returnItem.title, item.title)
    }
    
    func test_CheckItemAt_ChangesCounts() {
        
        sut.add(ToDoItem(title: ""))
        sut.checkItem(at: 0)
    }
    
    func test_CheckItemAt_RemovesItFromToDoItems() {
        
        let first = ToDoItem(title: "First")
        let second = ToDoItem(title: "Second")
        sut.add(first)
        sut.add(second)
        
        sut.checkItem(at: 0)
        
        XCTAssertEqual(sut.item(at: 0).title, "Second")
    }
    
    func test_DoneItemAt_ReturnsCheckedItem() {
        let item = ToDoItem(title: "Foo")
        sut.add(item)
        
        sut.checkItem(at: 0)
        let returnedItem = sut.doneItem(at: 0)
        XCTAssertEqual(returnedItem.title, item.title)
    }
    
    func text_EqualItems_AreEqual() {
        let first = ToDoItem(title: "Foo")
        let second = ToDoItem(title: "Foo")
        
        XCTAssertEqual(first, second)
    }
    
    func test_Items_WhenLocationDiffers_AreNotEqual() {
        let first = ToDoItem(title: "", location: Location(name: "Foo"))
        let second = ToDoItem(title: "", location: Location(name: "Bar"))
        XCTAssertNotEqual(first, second)
    }
    
}
