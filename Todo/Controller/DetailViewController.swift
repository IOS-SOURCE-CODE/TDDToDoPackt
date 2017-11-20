//
//  DetailViewController.swift
//  Todo
//
//  Created by Hiem Seyha on 11/20/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var itemInfo:(ItemManager, Int)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let itemInfo = itemInfo else { return }
        let item = itemInfo.0.item(at: itemInfo.1)
        
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        descriptionLabel.text = item.itemDescription
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter
        }()
        
        
        if let timestamp = item.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        if let coordinate =  item.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            mapView.region = region
        }
    }
    
    func checkItem(at index: Int) {
        
        if let item = itemInfo {
            item.0.checkItem(at: index)
        }
    }
}
