//
//  ToDoItem.swift
//  Todo
//
//  Created by Hiem Seyha on 11/16/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import Foundation

struct ToDoItem : Equatable{

    let title: String
    let itemDescription:String?
    let timestamp: Double?
    let location: Location?
    
    init(title:String, itemDescription:String? = nil,
         timestamp:Double? = nil,
         location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    if lhs.location?.name != rhs.location?.name {
        return false
    }
    return true
}
