//
//  ItemListViewController.swift
//  Todo
//
//  Created by Hiem Seyha on 11/17/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
    @IBOutlet weak var tableView: UITableView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }

}
