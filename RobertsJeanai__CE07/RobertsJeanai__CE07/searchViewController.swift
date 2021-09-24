//
//  searchViewController.swift
//  RobertsJeanai__CE07
//
//  Created by Nai Roberts on 8/21/21.
//

import UIKit

class searchViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate,  UITableViewDelegate, UITableViewDataSource {
    
    
    var zipcodes = [Location]()
    var searchController = UISearchController(searchResultsController: nil)
    var filteredZipCodes = [Location]()
    @IBOutlet weak var searchTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filteredZipCodes = zipcodes
        
        searchController.searchBar.isHidden = false
       
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.scopeButtonTitles = ["All", "TX", "NY"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        
        searchTableView.tableHeaderView = searchController.searchBar
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // set up tablevie rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredZipCodes.count
    }
    
    // Configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID2", for: indexPath) as UITableViewCell as! searchTableViewCell
        
        cell.cityStateLabel.text = filteredZipCodes[indexPath.row].cityState.description
        cell.populationLabel.text = filteredZipCodes[indexPath.row].population.description
        cell.zipCodeLabel.text = filteredZipCodes[indexPath.row].id.description
        
        return cell
    }
    
    
    
    // Update the results view
    func updateSearchResults(for searchController: UISearchController) {
        
        searchController.showsSearchResultsController = true
        
        
        let searchTxt = searchController.searchBar.text
        
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        filteredZipCodes = zipcodes
        
        if searchTxt?.isEmpty != nil {
            searchController.searchBar.showsSearchResultsButton = true
            filteredZipCodes = filteredZipCodes.filter({$0.city.range(of: searchTxt!.uppercased()) != nil})
        }
        if scopeTitle != "All"{
            filteredZipCodes = zipcodes.filter({ $0.state.range(of: scopeTitle) != nil })
        }

        
        searchTableView.reloadData()
        
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
