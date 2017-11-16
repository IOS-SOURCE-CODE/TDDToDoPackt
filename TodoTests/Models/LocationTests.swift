//
//  LocationTest.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/16/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest

@testable import Todo

import CoreLocation

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Init_whenGivenCoordinate_SetsCoordinate() {
        let coordinate = CLLocationCoordinate2D(latitude:1, longitude:2)
        
        let location = Location(name: "", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    func test_Init_WhenGivenName_SetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }
    
    func test_EqualLocation_AreEqual() {
        let first = Location(name: "Foo")
        let second = Location(name: "Foo")
        XCTAssertEqual(first, second)
    }
    
    func test_Location_WhenLongitudeDiffers_AreNotEqual() {
        
        performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLongLat: (1.0, 0.0), secondLongLat: (0.0,0.0), line: 55)
        
    }
    
    func performNotEqualTestWith(firstName:String, secondName:String, firstLongLat:(Double,Double)?,secondLongLat:(Double, Double)?, line:UInt ) {
        
        var firstCoord: CLLocationCoordinate2D? = nil
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        var secondCoord: CLLocationCoordinate2D? = nil
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
    }
    
}
