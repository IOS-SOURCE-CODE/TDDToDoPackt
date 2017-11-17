//
//  ItemListViewControllerTest.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/17/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest

@testable import Todo

class ItemListViewControllerTest: XCTestCase {
    
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        
         sut = viewController as! ItemListViewController
        _ = sut.view
    }
    
    override func tearDown() {
      
        super.tearDown()
    }
    
    func test_TableView_AfterViewDidLoad_IsNotNil() {
       
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_SetsTableViewDataSource() {
        
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    func test_LoadingView_SetsDataSourceAndDelegateToSameObject() {
        
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
    }
    
}
