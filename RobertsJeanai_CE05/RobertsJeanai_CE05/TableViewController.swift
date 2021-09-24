//  Jeanai Roberts
//  C202108 01
//  Code Exercise 05
//
//  TableViewController.swift
//  RobertsJeanai_CE05
//
//

import UIKit

class TableViewController: UITableViewController {

    // Data array for initial download
    var legislators = [Legislator]()
    
    var parties = [[Legislator](), [Legislator](), [Legislator]()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download JSON Data
        downloadJson(atUrl: "https://api.propublica.org/congress/v1/117/senate/members.json")
        downloadJson(atUrl: "https://api.propublica.org/congress/v1/117/house/members.json")

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    // Method for number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parties[section].count
    }
    
    // Method for height of cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // Method to Create, Configure and Display cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath) as? legisCell
        else{
            return tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath)
        }

        // Configure the cell...
        let currentLegislator = parties[indexPath.section][indexPath.row]
        
        var title = ""
        
        if currentLegislator.title != nil{
            title = currentLegislator.title
        }
        
        // Switch statement used to determine cell background color and display data
        switch currentLegislator.party {
        case "D":
            cell.backgroundColor = UIColor.blue
            cell.name.text = currentLegislator.fullName
            cell.title.text = title
            cell.stateParty.text = currentLegislator.partyId
            return cell
        case "R":
            cell.backgroundColor = UIColor.red
            cell.name.text = currentLegislator.fullName
            cell.title.text = currentLegislator.title
            cell.stateParty.text = currentLegislator.partyId
            return cell
        case "I":
            cell.backgroundColor = UIColor.yellow
            cell.name.text = currentLegislator.fullName
            cell.title.text = currentLegislator.title
            cell.stateParty.text = currentLegislator.partyId
            return cell
        default:
            return cell
        }
    }
    
    // Method for Section titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Democrat"
        case 1:
            return "Republican"
        case 2:
            return "Independent"
        default:
            return "No Section"
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Method for height of headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK: Segue to VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let legislatorToSend = parties[indexPath.section][indexPath.row]
            if let destination = segue.destination as? legislatorDetailsViewController{
                destination.legislator = legislatorToSend
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
