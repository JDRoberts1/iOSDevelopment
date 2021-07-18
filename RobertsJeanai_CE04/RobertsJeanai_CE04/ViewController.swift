//  Jeanai Roberts
//  C202107 01
//  Code Exercise 04
//
//  ViewController.swift
//  RobertsJeanai_CE04
//
//  Created by Nai Roberts on 7/18/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Data array for initial download
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Download data from source
        downloadJson(atUrl: "https://www.reddit.com/r/Awww/.json")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // determine number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuse_ID1", for: indexPath)
        
        // configure cell only if image is not nil
        if posts[indexPath.row].tImage != nil{
            cell.textLabel?.text = posts[indexPath.row].title
            cell.detailTextLabel?.text = posts[indexPath.row].author
            cell.imageView?.image = posts[indexPath.row].tImage
        }
        
        
        // return cell
        return cell
    }


}

