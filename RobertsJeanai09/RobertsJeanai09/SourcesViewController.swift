//
//  SourcesViewController.swift
//  RobertsJeanai09
//
//  Created by Nai Roberts on 8/25/21.
//

import UIKit

class SourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var filteredSources = [[Source](),[Source](),[Source](),[Source](),[Source](),[Source]()]


    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        // View is identified in the navigation bar
        navigationItem.title = "Sources"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Method for height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // Method for number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredSources[section].count
    }
    
    // MARK: Custom TableView Cell
    // Create, Configure and Display the Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath) as? sourceTableViewCell
        else{
            return tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath)
        }
        
        let currentSource = filteredSources[indexPath.section][indexPath.row]
        
        // Custom Cells displays the name of the source and UserDefault color if available
 
        if let textColor = UserDefaults.standard.object(forKey: "textColor") as? UIColor{
            cell.nameLabel.textColor = textColor
        }
        
        
        cell.nameLabel.text = currentSource.name
        
        return cell
    }
    
    // Method for the height of the header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // Method for the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredSources.count
    }
    
    // Method for titles of each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "General"
        case 1:
            return "Technology"
        case 2:
            return "Sports"
        case 3:
            return "Business"
        case 4:
            return "Entertainment"
        case 5:
            return "Science"
        default:
            return "No Title"
        }
    }
    

    
    // MARK: - Navigation

    // Selecting a cell will take the user to the Articles View.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ArticlesViewController{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let selectedSource = filteredSources[indexPath.section][indexPath.row]
                
                destination.selectedSource = selectedSource
                
            }
        }
        
    }
    

}
