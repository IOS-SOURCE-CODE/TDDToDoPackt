//
//  ItemCellTests.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/18/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest
import UIKit

@testable import Todo

class ItemCellTests: XCTestCase {
    
    var tableView:UITableView!
    let datasource = FakeDataSource()
    var cell: ItemCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = controller.view
         tableView = controller.tableView
    
        tableView?.dataSource = datasource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    

}


extension ItemCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             return UITableViewCell()
        }
    }
    
    func test_hasNameLabel() {
        
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func test_HashLocationLabel() {
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func test_hasDateLabel() {
        
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func test_ConfigCell_SetsText() {
        
        let location = Location(name: "Bar")
        let item =  ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
        cell.configCell(with:item)
        XCTAssertEqual(cell.titleLabel.text, "Foo")
        XCTAssertEqual(cell.locationLabel.text, "Bar")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func test_Title_WhenItemIsCheck_IsStrokeThrough () {
        
        let location = Location(name: "Bar")
        let item = ToDoItem(title: "Foo", itemDescription: nil, timestamp: 1456150025, location: location)
        cell.configCell(with: item, checked: true)
        
        let attributeString = NSAttributedString(string: "Foo", attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributeString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}











