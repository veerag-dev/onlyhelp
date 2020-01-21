//
//  MenuTableViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 29/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hello, \(defaults.value(forKey: userFullname) ?? "there")"
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 10, width: 200, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.textColor = .white
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        headerView.addSubview(myLabel)

        return headerView
    }

    
}
