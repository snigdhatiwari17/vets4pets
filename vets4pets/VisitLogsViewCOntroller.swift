//
//  EMRViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 27/04/23.
//

import UIKit

class VisitLogsViewCOntroller: UITableViewController {
    
    
    
    let petDetailTitles = ["04/04/2023","07/06/2023","18/06/2023","27/08/2023"]
    

    let petDetails = [ "vaccination","check-up","ear clean","check-up"]
    
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
