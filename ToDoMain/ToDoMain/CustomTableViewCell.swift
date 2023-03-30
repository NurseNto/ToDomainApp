//
//  CustomTableViewCell.swift
//  ToDoMain
//
//  Created by Nurse Ntombi Masango on 2022/08/31.
//

import UIKit

protocol isDone{
    func toggleIsDone(for cell: UITableViewCell)
}
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMark: UIButton!
    
    var isDoneDelegate: isDone?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    let models = [ToDoApp]()
    
    func setCell(task: String, isChecked: Bool) {
        
        if  isChecked{
            checkMark.setImage(UIImage(systemName: "checkmark.diamond.fill"), for: .normal)
        }
        else{
            checkMark.setImage(UIImage(systemName: "diamond"), for: .normal)
        }
    }
    
    @IBAction func checkedTapped(_ sender: Any) {
        isDoneDelegate?.toggleIsDone(for: self)
    }

}
