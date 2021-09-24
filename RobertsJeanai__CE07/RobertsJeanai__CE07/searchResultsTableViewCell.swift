//
//  searchResultsTableViewCell.swift
//  RobertsJeanai__CE07
//
//  Created by Nai Roberts on 8/21/21.
//

import UIKit

class searchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
