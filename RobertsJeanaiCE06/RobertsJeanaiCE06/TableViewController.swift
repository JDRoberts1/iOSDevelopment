//
//  TableViewController.swift
//  RobertsJeanaiCE06
//
//  Created by Nai Roberts on 7/21/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var stores = [Store]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Register Header xib
        let headerXib = UINib.init(nibName: "storeHeader", bundle: nil)
        tableView.register(headerXib, forHeaderFooterViewReuseIdentifier: "header_ID1")
        
        // Download JSON File and Display data
        if let path = Bundle.main.path(forResource: "StoreJSON", ofType: ".json"){
            let url = URL(fileURLWithPath: path)
            
            do{
                let data = try Data.init(contentsOf: url)
                
                let jsonObJ = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                downloadAndParseJson(jsonObj: jsonObJ)
            }
            catch{
                print(error.localizedDescription)
            }
        }
        
    }

    // MARK: - Table view data source
    // Method for the numbe rof sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Method to determine the number of rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }
    
    // Method for the height of the cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // Method to Create, Configure and Return cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create Cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? storeTableViewCell
        else{
            return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }

        // Configure the cell...
        let currentStore = stores[indexPath.row]
        cell.storeNameLabel.text = currentStore.storeName.description
        
        if currentStore.storeItems != nil{
            cell.itemCountLabel.text = currentStore.coutOfItems.description
        }
        else{
            cell.itemCountLabel.text = "0"
        }
        
    
        
        return cell
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            stores.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            
        }
        
    }
    
    
    // MARK: - HEADER SECTION
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    // MARK: - Create custom header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID1") as? storeViewHeader
        
        header?.storeCountLabel.text = stores.count.description
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.backgroundColor = UIColor.orange
        header?.backgroundConfiguration = backgroundConfig

        
        return header
    }
    
    // MARK: - Download & Parse Data
    // Method used to download and parse data
    func downloadAndParseJson(jsonObj: [Any]?){
        
        guard let json = jsonObj
        else{assertionFailure("Parse 1 failed"); return}
        
        for firstLevelItem in json{
            
            guard let item = firstLevelItem as? [String: Any],
                  let storeName = item["storename"] as? String,
                  let items = item["items"] as? [String]
            else{assertionFailure("Parse 2 failed"); return}
            
            var itemList = [StoreItem]()
            
            for i in items{
                itemList.append(StoreItem(item: i))
            }
            
            stores.append(Store(storeName: storeName, storeItems: itemList))
            
        }
        
    }
    
    // MARK: - Add Button
    // IBAction method for add Button to add new list
    @IBAction func addNewStore(_sender: UIButton){
        
        // Create new Alert
        let newAlert = UIAlertController(title: "New Shopping List", message: "Please enter the name of the list", preferredStyle: .alert)
        
        // Add Ok button to Alert
        newAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            if newAlert.textFields?.first?.text != ""{
                
                if let newList = newAlert.textFields?.first?.text{
                    self.stores.append(Store(storeName: newList))
                    
                }
                
                self.tableView.reloadData()
                
            }
        }))
        
        // Add the cancel button to Alert
        newAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add text field to Alert
        newAlert.addTextField(configurationHandler: nil)
        
        // Present Alert
        self.present(newAlert, animated: true)
        
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? StoreTableViewController{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let selectedList = stores[indexPath.row]
                
                destination.selectedList.append(selectedList)
                
            }
            
            
        }
        
        tableView.reloadData()
        
        
    }
    
    

}
