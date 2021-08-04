//
//  ViewController.swift
//  RobertsJeanai_CE07
//
//  Created by Nai Roberts on 7/24/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate,  UITableViewDelegate, UITableViewDataSource{
    
    
    
    var zipcodes = [Location]()
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var filteredZipCodes = [Location]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json"){
            
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                parseAndDownload(jsonObject: jsonObj)
                filteredZipCodes = zipcodes
                
                print(zipcodes)
                
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // set up tablevie rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredZipCodes.count
    }
    
    // Configure cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath) as UITableViewCell
        
        
        
        cell.textLabel?.text = filteredZipCodes[indexPath.row].state.description
        cell.detailTextLabel?.text = filteredZipCodes[indexPath.row].city.description
        
        
        return cell
        
    }
    
    // Hides the search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
    }
    
    // button to display the search button
    @IBAction func searchAction(_ sender: UIBarButtonItem){
        
        searchController.searchBar.isHidden = false
        searchController.definesPresentationContext = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All", "TX", "NY"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        tableView.tableHeaderView =  searchController.searchBar
    }
    
    // Update the results view
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchTxt = searchController.searchBar.text
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        
        if searchTxt != nil{
            filteredZipCodes = zipcodes.filter({ $0.city.range(of: searchTxt!.uppercased()) != nil })
        }
        if scopeTitle != "All"{
            filteredZipCodes = zipcodes.filter({ $0.state.range(of: scopeTitle) != nil })
        }
        else{
            filteredZipCodes = zipcodes
        }
        
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        updateSearchResults(for: searchController)
        
    }
    
    
    // Method to parse JSON file
    func parseAndDownload(jsonObject: [Any]?){
        guard let json = jsonObject
        else{assertionFailure("Parse failed at JSON"); return}
        
        for obj in json{
            guard let object = obj as? [String: Any],
                  let city = object["city"] as? String,
                  let location = object["loc"] as? [Double],
                  let population = object["pop"] as? Int32,
                  let state = object["state"] as? String,
                  let id = object["_id"] as? String
            else{assertionFailure("Parse failed at JSON"); return}
            
            zipcodes.append(Location(city: city, location: location, population: population, state: state, id: id))
                  
        }
        
        
        
    }


}

