//
//  TodoTests.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/16/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest

@testable import Todo

class TodoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_WhenGivenTitle_SetsTitle() {
     
        let item = ToDoItem(title: "Foo", itemDescription: nil)
        XCTAssertEqual(item.title,"Foo","Should set title")
    }
    
    func test_Init_WhenGivenDescription_SetsDescription() {
        let item = ToDoItem(title: "Foo", itemDescription: "Bar")
        XCTAssertEqual(item.itemDescription, "Bar", "Should set itemDescription")
    }
    
    func test_Init_WhenGivenLocation_SetsLocation() {
        let location = Location(name: "Foo")
        let item = ToDoItem(title: "", itemDescription: nil, location: location)
        
        XCTAssertEqual(item.location?.name,location.name, "should set location")
    }
    
}
