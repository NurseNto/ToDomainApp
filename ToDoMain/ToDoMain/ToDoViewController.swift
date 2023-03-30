
//  Created by Nurse Ntombi Masango on 2022/09/06.
//

import UIKit
import CoreData

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
    var models = [ToDoApp]()
    
    var editIndexPath: Int?
    
    var selectedCategory: Category?{
        didSet{
            loadTask()
        }
    }

    @IBOutlet weak var taskTableView: UITableView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        title = "TO DO"
            //getAllTasks()
            taskTableView.delegate = self
            taskTableView.dataSource = self
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        taskTableView.reloadData()
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let alert = UIAlertController(title: "New Task", message: "Enter New Task", preferredStyle: .alert)
              alert.addTextField(configurationHandler: nil)
              alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                  guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                      return
                  }
                  self?.createTask(name: text)
                  self?.saveItems()
              }))
              
              present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? CustomTableViewCell
        cell?.setCell(task: model.name!, isChecked: model.completedAt)
        cell?.textLabel?.text = model.name
        
        cell?.isDoneDelegate = self
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //tableView.deselectRow(at: indexPath, animated: true)
        
       performSegue(withIdentifier: "EditVc", sender: indexPath)
        tableView.reloadData()
    }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? EditViewController {
             destination.indexPath = editIndexPath
         }
     }

     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = models[indexPath.row]

       
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, view, completion) in
            let dialogMessage = UIAlertController(title: "Confirm Please", message: "Are you sure you want to delete this?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                print("ok tapped")
                //call the delete function
                self.deleteTask(item: item)
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("cancel tapped")
            }
            
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            present(dialogMessage, animated: true, completion: nil)
            
        }
        
        let archiveAction = UIContextualAction(style: .normal, title: "Archive"){(action, view, completion) in
            let item = self.models[indexPath.row]
            item.isArchived.toggle()
            tableView.reloadData()
            print(item.isArchived)
            do{
                try self.context.save()
                
            }
            catch{
                
            }
        }
        archiveAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [archiveAction, deleteAction])
    }
    
    func toggleDone(for index: Int) {
        models[index].completedAt.toggle()
        
        do {
            try context.save()
        }
        catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = models[indexPath.row]
        
        if item.isArchived {
            return 0
        }
        else{
            return 43.5
        }
    }
    
    //core data functions:
       
       func getAllTasks() {
           do{
               models = try context.fetch(ToDoApp.fetchRequest())
               
               DispatchQueue.main.async {
                   self.taskTableView.reloadData()
               }
               
           }
           catch{
               print("Error getting the data")
           }
       }
    
    func saveItems(){
        do{
            try context.save()
        }catch {
            print("Error saving context with \(error)")
        }
        
        self.taskTableView.reloadData()
        
    }
       func createTask(name: String) {
           let newTasks = ToDoApp(context: context)
           newTasks.name = name
           newTasks.category = selectedCategory
           models.append(newTasks)
           newTasks.createdAt = Date()
           
           //save to the database
           do{
               try context.save()
               
           }
           catch{
              print("")
           }
       }
    func loadTask(with request:NSFetchRequest<ToDoApp> = ToDoApp.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "category.title MATCHES %@", selectedCategory!.title!)
        if let additionalPred = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPred])
        }else{
            request.predicate = categoryPredicate
        }
        
        do{
            models = try context.fetch(request)
        }catch{
            
        }
        taskTableView.reloadData()
    }

    func deleteTask(item: ToDoApp) {
        context.delete(item)
        getAllTasks()
        
        do{
            try context.save()
            
        }
        catch{
            
        }
   }
}

extension ToDoViewController: isDone {
    func toggleIsDone(for cell: UITableViewCell) {
        if let indexPath = taskTableView.indexPath(for: cell) {
            toggleDone(for: indexPath.row)
            taskTableView.reloadData()
        }
    }
}
