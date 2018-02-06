//
//  ViewController.swift
//  planner
//
//  Created by ر on ٢٠ ربيع٢، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import UIKit
import RealmSwift

class planelistviewcontroller: UITableViewController  {
    var todolist : Results<Item>?
    let realm = try! Realm()
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
//        todolist.append(newitem)
//
//        let newitem2 = Item()
//        newitem2.title = "tryprog"
//        todolist.append(newitem2)
//
//        let newitem3 = Item()
//        newitem3.title = "tryphoto"
        
      //  loaddata()
        // tableview data sourse method
        
//        if let  items = defaults.array(forKey: "plannerlistarray") as? [String]{
//            todolist = items
//        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "planneritemlist", for: indexPath)
        if   let item = todolist?[indexPath.row]{
        cell.textLabel?.text = item.title
        
        cell.accessoryType =  item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "no item added"
        }
        
//        if  item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
       return cell

        
    }
     // tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todolist?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("ërror saving done\(error)")
            }
        }
        
    tableView.reloadData()
        
        
    //    print(todolist[indexPath.row])
//        context.delet(todolist[indexPath.row])
//        todolist.remove(at: indexPath.row)
        
        
      //  todolist[indexPath.row].done = !todolist[indexPath.row].done
        //the single lin short the down code
//        if   todolist[indexPath.row].done == false {
//             todolist[indexPath.row].done = true
//        }else{
//             todolist[indexPath.row].done = false
//        }
//        saveitem()
//         tableView.reloadData()
      tableView.deselectRow(at: indexPath, animated: true)
//
    }
   // add new item
    
    @IBAction func addbuttonpressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new plane", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
          
            
            if let currentcategory = self.selectedcategory {
                do{
                    try self.realm.write {
                        let newitem = Item()
                        newitem.title = textfield.text!
                        newitem.datecreated = Date()
                        currentcategory.item.append(newitem)
                    }
                }catch{
                    print("error saving item\(error)")
                }
               
                
            }
//            let newitem = Item(context:self.context)
//            newitem.title = textfield.text!
//            newitem.done = false
//            newitem.parentcategory = self.selectedcategory
//            self.todolist.append(newitem)
         //  self.saveitem()
//           self.defaults.set(self.todolist, forKey: "plannerlistarray")
           self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
//    func saveitem (){
//        do {
//            try context.save()
//
//        }
//        catch{
//            print("error saving context \(error)")
//        }
//        self.tableView.reloadData()
//
//    }
    func loaddata(){
        
        todolist = selectedcategory?.item.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
        
        //(whith request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
//        let categorypredicate = NSPredicate(format: "parentcategory.name MATCHES %@", selectedcategory!.name!)
//        if let additionalpredicate = predicate {
//           request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categorypredicate,additionalpredicate])
//        }else{
//            request.predicate = categorypredicate
//        }
//        do{
//        todolist = try context.fetch(request)
//        }catch{
//            print("catching error \(error)")
//        }
//
//
//    }
    
    }}

extension planelistviewcontroller : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todolist = todolist?.filter(NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)).sorted(byKeyPath: "datecreated", ascending: true)

//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//       let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loaddata(whith: request, predicate: predicate)
//
//
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


















