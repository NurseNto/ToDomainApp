//
//  CreateCategoryViewController.swift
//  ToDoMain
//
//  Created by Nurse Ntombi Masango on 2022/09/07.
//

import UIKit

class CreateCategoryViewController: UIViewController, UITextFieldDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleText: UITextField!
    
    var category = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleText.delegate = self
    }
    
    
    

    @IBAction func saveCtegory(_ sender: Any) {
        let taskToUpdate = titleText.text
    
        createCategory(name: taskToUpdate!)
          
        
      self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func createCategory(name: String) {
        let newTasks = Category(context: context)
        newTasks.title = name
        
        //save to the database
        do{
            try context.save()
            getAllTasks()
        }
        catch{
           print("")
        }
    }
    
    func getAllTasks() {
        do{
            category = try context.fetch(Category.fetchRequest())
        }
        catch{
            print("Error getting the data")
        }
    }
    
}
