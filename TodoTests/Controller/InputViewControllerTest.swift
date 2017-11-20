//
//  InputViewController.swift
//  TodoTests
//
//  Created by Hiem Seyha on 11/20/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import XCTest
@testable import Todo

import CoreLocation

class InputViewControllerTest: XCTestCase {
    
    var sut:InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_HashTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    func test_HashDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    func test_HashAddressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func test_HashDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func test_HashLocationextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func test_HashSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    
    func test_HashCancelButton() {
        XCTAssertNotNil(sut.cancelButton)
    }
    
    func test_Save_UsesGeocoderToGetCoordinateFromAddress() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM/dd/yyyy"
        let timestamp = 477766800.0
        let date = Date(timeIntervalSinceReferenceDate: timestamp)
        
        sut.titleTextField.text = "Foo"
        sut.dateTextField.text = dateFormatter.string(from: date)
        sut.locationTextField.text = "Bar"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Baz"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.item(at: 0)
        
        let testItem = ToDoItem(title: "Foo", itemDescription: "Baz", timestamp: timestamp, location: Location(name: "Bar", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
        
    }
    
    func test_SaveButtonHasAction() {
        
        let saveButton = sut.saveButton
        guard let action = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(action.contains("save"))
    }
}

extension InputViewControllerTest {
    
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
}

extension InputViewControllerTest {
    
    class MockPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation()}
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}
