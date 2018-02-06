//
//  categoryViewController.swift
//  planner
//
//  Created by ر on ٦ جما١، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ ر. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class categoryViewController: UITableViewController {
    let realm = try! Realm()
    var categores : Results<Category>?
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

       loadcategory()
        
    }
    //MARK: -Tableview datat sourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categores?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorycell", for: indexPath)
       cell.textLabel?.text = categores?[indexPath.row].name ?? "no category yet"
      //  cell.textLabel?.text = categ.name
      //  cell.accessoryType =  item.done ? .checkmark : .none

        return cell
        
        
    }
    //MARK: -Tableview datat delegate
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoitems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! planelistviewcontroller
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedcategory = categores?[indexPath.row]
        }
    }
  
    @IBAction func buttonpressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "add new plane", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            
            let newcategory = Category()
            newcategory.name = textfield.text!
    
          //  self.categores.append(newcategory)
            self.save(category: newcategory)

            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textfield = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func save(category:Category){
        do {
            try realm.write{
                realm.add(category)
            }
            
        }
        catch{
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    func loadcategory(){
        categores = realm.objects(Category.self)
//        let  request : NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//            categores = try context.fetch(request)
//        }catch{
//            print("catching error \(error)")
//        }
       tableView.reloadData()
        
        
    }
}
























































