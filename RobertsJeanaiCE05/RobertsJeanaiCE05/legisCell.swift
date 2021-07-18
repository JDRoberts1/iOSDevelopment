//
//  legisCell.swift
//  RobertsJeanaiCE05
//
//  Created by Nai Roberts on 7/18/21.
//

import UIKit

class legisCell: UITableViewCell{
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var partyState: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
