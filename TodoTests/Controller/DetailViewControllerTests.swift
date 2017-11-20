//
//  DetailViewControllerTests.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/20/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Todo

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_HasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HashMap() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func test_SettingItemInfo_SetsTextToLabels() {
        
        let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
        let location = Location(name: "Foo", coordinate: coordinate)
        let item = ToDoItem(title: "Bar", itemDescription: "Baz", timestamp: 1456150025, location: location)
        let itemManager = ItemManager()
        itemManager.add(item)
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Bar")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Foo")
        XCTAssertEqual(sut.descriptionLabel.text, "Baz")
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.01)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.01)
    }
    
    func test_CheckItem_ChecksItemInItemManager() {
        
        let itemManager = ItemManager()
        itemManager.add(ToDoItem(title: "Foo"))
        sut.itemInfo = (itemManager,0)
        sut.checkItem(at: 0)
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
        
    }
}
