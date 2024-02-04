//
//  InventoryViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 04/02/24.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController, UITableViewDataSource {
    
    
  
    var Medicines = ["BiResp Spiromax","Cablivi","Bekemv","Constella"]
    

    var quantity = ["2","7","30","5"]
    
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var confirmButton: UIButton!
    

    @IBOutlet weak var tableViewSection: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSection.dataSource = self
        
   
              
    }
    


    // MARK: - Table View Data Source Method

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return Medicines.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: K.resusableEMRcell, for: indexPath)
   
   cell.textLabel?.text = String(Medicines[indexPath.row])
   cell.textLabel?.font = .boldSystemFont(ofSize: 17)
   
       cell.accessoryView?.isHidden = true
       cell.detailTextLabel?.text = String(quantity[indexPath.row])
   
   return cell
}
    
    
    @IBAction func confirmPressed(_ sender: Any) {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            var newLabel = textfield.text
            var index = indexPath.row
            
            quantity[index] = newLabel!
            
            tableViewSection.reloadData()
            
      
        }
        
    }
    
    
    
}
