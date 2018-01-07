//
//  ViewController.swift
//  planner
//
//  Created by ر on ٢٠ ربيع٢، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import UIKit

class planelistviewcontroller: UITableViewController {
let itemarray = ["making cake","try more prog","use photo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview data sourse method
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planneritemlist", for: indexPath)
        cell.textLabel?.text = itemarray[indexPath.row]
        return cell
    }
     // tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemarray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }}
