//
//  ViewController.swift
//  RobertsJeanaiCE07
//
//  Created by Nai Roberts on 7/24/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchControllerDelegate {
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var zipcodes = [Location]()
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
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredZipCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath)
        
        return cell
    }
    
    @IBAction func selectedSearchButton(_ sender: UIBarItem){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All", "TX", "WA"]
        navigationItem.searchController = searchController
    }
    
}

