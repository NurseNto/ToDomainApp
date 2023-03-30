//
//  EditViewController.swift
//  ToDoMain
//
//  Created by Nurse Ntombi Masango on 2022/08/31.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var models = [ToDoApp]()
    var indexPath: Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
        textField.text = models[indexPath ?? 0].name
    }
   
    
    @IBAction func save(_ sender: Any) {
        let item = models[indexPath!]
        let task = textField.text
        
        updateTask(item: item, newName: task!)
        getAllTasks()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func getAllTasks() {
        do{
            models = try context.fetch(ToDoApp.fetchRequest())
            
        }
        catch{
            print("Error getting the data")
        }
    }
    func updateTask(item: ToDoApp, newName: String) {
         item.name = newName
         
         do{
             try context.save()
             getAllTasks()
         }
         catch{
             
         }
     }
}
