//
//  ViewController.swift
//  planner
//
//  Created by ر on ٢٠ ربيع٢، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import UIKit
import CoreData

class planelistviewcontroller: UITableViewController  {
    var itemarray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedcategory : Category?{
        didSet{
             loaddata()
        }
    }
//    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
//
//        let newitem = Item()
//        newitem.title = "making cake"
//        itemarray.append(newitem)
//
//        let newitem2 = Item()
//        newitem2.title = "tryprog"
//        itemarray.append(newitem2)
//
//        let newitem3 = Item()
//        newitem3.title = "tryphoto"
        
      //  loaddata()
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
//        context.delet(itemarray[indexPath.row])
//        itemarray.remove(at: indexPath.row)
        
        
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
          
            let newitem = Item(context:self.context)
            newitem.title = textfield.text!
            newitem.done = false
            newitem.parentcategory = self.selectedcategory
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
        do {
            try context.save()
            
        }
        catch{
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loaddata(whith request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        let categorypredicate = NSPredicate(format: "parentcategory.name MATCHES %@", selectedcategory!.name!)
        if let additionalpredicate = predicate {
           request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,additionalpredicate])
        }else{
            request.predicate = categorypredicate
        }
        do{
        itemarray = try context.fetch(request)
        }catch{
            print("catching error \(error)")
        }


    }
    
}

extension planelistviewcontroller : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loaddata(whith: request, predicate: predicate)
    
    
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loaddata()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    
    
}


















