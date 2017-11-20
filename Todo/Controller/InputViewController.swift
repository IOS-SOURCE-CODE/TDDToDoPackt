//
//  InputViewControllerViewController.swift
//  Todo
//
//  Created by Hiem Seyha on 11/20/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import UIKit
import CoreLocation
class InputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField:UITextField!
    
    @IBOutlet weak var locationTextField:UITextField!
    @IBOutlet weak var addressTextField:UITextField!
    @IBOutlet weak var descriptionTextField:UITextField!
    
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save() {
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter
        }()
        
        guard let titleString = titleTextField.text,
        titleString.count > 0   else {
            return
        }
        
        let dateValue: Date?
        if let dateText = self.dateTextField.text,
            dateText.count > 0 {
            dateValue = dateFormatter.date(from: dateText)
           
        } else {
            dateValue = nil
        }
        
        let descriptionString = descriptionTextField.text
        if let locationName = locationTextField.text, locationName.count > 0 {
            if let address = addressTextField.text, address.count > 0 {
                
                
            
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    
                    let placeMark = placeMarks?.first
                
                    let item = ToDoItem(
                    title: titleString,
                    itemDescription: descriptionString,
                    timestamp: dateValue?.timeIntervalSinceReferenceDate,
                    location: Location(
                    name: locationName,
                    coordinate: placeMark?.location?.coordinate))
                    
                    
                    self.itemManager?.add(item)
                }
                
            }
        }
    }
    
}
