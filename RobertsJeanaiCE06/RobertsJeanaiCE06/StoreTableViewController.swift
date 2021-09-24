//
//  StoreTableViewController.swift
//  RobertsJeanaiCE06
//
//  Created by Nai Roberts on 7/21/21.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    var selectedList = [Store]()
    var itemList = [[StoreItem](), [StoreItem]()]
    
    var backBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Create and Register the custom headers
        let needToPurchaseHeader = UINib.init(nibName: "needToBuyHeader", bundle: nil)
        tableView.register(needToPurchaseHeader, forHeaderFooterViewReuseIdentifier: "header_ID2")
        
        let purchsedItemsHeade = UINib.init(nibName: "PurchasedHeader", bundle: nil)
        tableView.register(purchsedItemsHeade, forHeaderFooterViewReuseIdentifier: "header_ID3")
        
        // Method to filter items on isPurchased property
        filterByIsPurchased()
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    // Method to determine number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList[section].count
    }
    
    // MARK: Cell Creation
    // Method to Create, Confiure and Display the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID2", for: indexPath)
        
        
        // Configure the cell...
        let currentItem = itemList[indexPath.section][indexPath.row]
        
        
        if currentItem.item != ""{
            cell.textLabel?.text = currentItem.item
        }
        
        
        // Display cell
        return cell
    }
    
    // Memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Method to filter items into correct array
    func filterByIsPurchased(){
        for item in selectedList[0].storeItems{
            if item.isPurchased != true{
                itemList[0].append(item)
            }
            else{
                itemList[1].append(item)
            }
        }
        
        
    }
    
    // MARK: View for Header method
    // Method to create the view for custom headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID2") as? needToPurchase
            
            header?.SectionLabel.text = "Need to Purchase"
            header?.CountLabel.text = itemList[0].count.description
            
            
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header_ID3") as? PurchasedItemsHeader
            header?.SectionLabel.text = "Purchased Items"
            
            if itemList[1].count != 0{
                header?.CountLabel.text = itemList[1].count.description
            }
            else{
                header?.CountLabel.text = "0"
            }
            
            
            return header
            
        default:
            let header = tableView.headerView(forSection: 0)
            
            return header
        }
        
        
        
    }
    // Method for height of header
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Alert user to confirm they would like to delete the item
            let alert = UIAlertController(title: "Remove Item?", message: "Are you sure you would like to remove item from the list?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
                if alert.textFields?.first?.text != ""{
                    
                    // Delete the row from the data source
                    self.itemList[indexPath.section].remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                    self.tableView.reloadData()
                    
                }
            }))
            
            // Add the cancel button to Alert
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            
            // Present Alert
            self.present(alert, animated: true)
            
            
        }
    
    }
    
    // MARK: Add Item Button
    // func to add new item to list
    @IBAction func AddNewItem(_ sender: UIButton){
        
        // Alert created for user to enter new item
        let alert = UIAlertController(title: "Add New Item", message: "Please enter the name of the item you would like to add!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {action in
            if alert.textFields?.first?.text != ""{
                
                if let newItem = alert.textFields?.first?.text{
                    self.itemList[0].append(StoreItem(item: newItem))
                    self.selectedList[0].storeItems.append(StoreItem(item: newItem))
                    
                }
                
                self.tableView.reloadData()
                
            }
        }))
        
        // Add the cancel button to Alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add text field to Alert
        alert.addTextField(configurationHandler: nil)
        
        // Present Alert
        self.present(alert, animated: true)
    }
    
    // MARK: cellIsTapped method
    // Method to move cell when user taps it
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = itemList[indexPath.section][indexPath.row]
        
        if selectedItem.isPurchased == false{
            selectedItem.isPurchased = true
            itemList[1].append(StoreItem(item: selectedItem.item))
            itemList[0].remove(at: indexPath.row)
        }
        else if selectedItem.isPurchased != false{
            selectedItem.isPurchased = false
            itemList[0].append(StoreItem(item: selectedItem.item))
            itemList[1].remove(at: indexPath.row)
        }
        
        tableView.reloadData()
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
