
//
//  InventoryViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 04/02/24.
//

import Foundation
import UIKit

class PaymentDatabaseViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewSection: UITableView!
    
    var Users = ["John","Lucy","Harry","Leo"]
    

    var quantity = ["2Rs","7Rs","30Rs","5Rs"]
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSection.dataSource = self
        
   
              
    }
    


    // MARK: - Table View Data Source Method

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return Users.count
}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: K.resusableEMRcell, for: indexPath)
   
        cell.textLabel?.text = String(Users[indexPath.row])
   cell.textLabel?.font = .boldSystemFont(ofSize: 17)
   
       cell.accessoryView?.isHidden = true
       cell.detailTextLabel?.text = String(quantity[indexPath.row])
   
   return cell
}
    
    
   
    
    
    
}
