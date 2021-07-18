//  Jeanai Roberts
//  C202107 01
//  Code Exercise 05
//
//  TableViewController.swift
//  RobertsJeanaiCE05
//
//  Created by Nai Roberts on 7/17/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    // Data array for initial download
    var legislators = [Legislator]()
    
    var parties = [[Legislator](), [Legislator](), [Legislator]()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson(atUrl: "https://api.propublica.org/congress/v1/117/senate/members.json")

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parties[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath)

        // Configure the cell...

        return cell
    }
    
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

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
