//  Jeanai Roberts
//  C202107 01
//  Code Exercise 05
//
//  legisCell.swift
//  RobertsJeanai_CE05
//
//  Created by Nai Roberts on 7/18/21.
//

import UIKit

class legisCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var stateParty: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
