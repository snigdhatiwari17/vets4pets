//
//  EMRViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 27/04/23.
//

import UIKit

class TreatmentHistoryViewController: UITableViewController {
    
    
    
    let petDetailTitles = ["16/08/2023","31/09/2023"]
    

    let petDetails = [ "Hydroxyzing Tablets","Procaine"]
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.largeContentTitle = "pet name"
    }
    
    
        // MARK: - Table View Data Source Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petDetailTitles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.resusableEMRcell, for: indexPath)
        
        cell.textLabel?.text = String(petDetailTitles[indexPath.row])
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        
        if  indexPath.row <= 3 {
            cell.accessoryView?.isHidden = true
            cell.detailTextLabel?.text = String(petDetails[indexPath.row])
        }
        return cell
    }
}
