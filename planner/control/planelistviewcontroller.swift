//
//  ViewController.swift
//  planner
//
//  Created by ر on ٢٠ ربيع٢، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import UIKit

class planelistviewcontroller: UITableViewController {
    var itemarray = [Item]()
 let datafilepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")

//    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       print(datafilepath)
        
        
        
        let newitem = Item()
        newitem.title = "making cake"
        itemarray.append(newitem)
        
        let newitem2 = Item()
        newitem2.title = "tryprog"
        itemarray.append(newitem2)
        
        let newitem3 = Item()
        newitem3.title = "tryphoto"
      loaddata()
        // tableview data sourse method
        
//        if let  items = defaults.array(forKey: "plannerlistarray") as? [String]{
//            itemarray = items
//        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemarray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "planneritemlist", for: indexPath)
        let item = itemarray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType =  item.done ? .checkmark : .none
        
        
//        if  item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
       return cell

        
    }
     // tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    print(itemarray[indexPath.row])
        
        itemarray[indexPath.row].done = !itemarray[indexPath.row].done
        //the single lin short the down code
//        if   itemarray[indexPath.row].done == false {
//             itemarray[indexPath.row].done = true
//        }else{
//             itemarray[indexPath.row].done = false
//        }
        saveitem()
        // tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
      
    }
    // add new item
    
    @IBAction func addbuttonpressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new plane", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            let newitem = Item()
            newitem.title = textfield.text!
            self.itemarray.append(newitem)
           self.saveitem()
//            self.defaults.set(self.itemarray, forKey: "plannerlistarray")
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveitem (){
        let encoder = PropertyListEncoder ()
        do {
            let data = try encoder.encode(itemarray)
            try data.write(to: datafilepath!)
        }
        catch{print("error\(error)")}
        self.tableView.reloadData()
        
    }
    func loaddata(){
        if let data = try? Data(contentsOf: datafilepath!){
            let decoder = PropertyListDecoder()
            do{
                itemarray = try decoder.decode([Item].self, from: data)
            }catch{
                print("decoder error\(error)")
            }
            
            
        }
        
        
    }
    
}
