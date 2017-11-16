//
//  Location.swift
//  Todo
//
//  Created by Hiem Seyha on 11/16/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name:String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

func == (lhs: Location, rhs: Location) -> Bool {
    
    if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
        return false
    }
    return true
}
