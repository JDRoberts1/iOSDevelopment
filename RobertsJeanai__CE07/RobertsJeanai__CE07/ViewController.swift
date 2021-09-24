//
//  ViewController.swift
//  RobertsJeanai__CE07
//
//  Created by Nai Roberts on 8/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var zipcodes = [Location]()
    var filteredZipCodes = [Location]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json"){
            
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                parseAndDownload(jsonObject: jsonObj)
                
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? searchViewController
        
        print(zipcodes.count)
        
        destination?.zipcodes = zipcodes
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredZipCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath) as UITableViewCell as! searchResultsTableViewCell
        
        cell.cityStateLabel.text = zipcodes[indexPath.row].cityState.description
        cell.populationLabel.text = "Population: \(zipcodes[indexPath.row].population.description)"
        cell.zipCodeLabel.text = "Zipcode: \(zipcodes[indexPath.row].id.description)"
        
        
        return cell
    }
    
    @IBAction func clearResults(_ sender: Any) {
        
        filteredZipCodes.removeAll()
        tableView.reloadData()
        
        
    }
    
}

