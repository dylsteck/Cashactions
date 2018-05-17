//
//  TableViewCellCA.swift
//  Cashactions
//
//  Created by Dylan Steck on 5/16/18.
//  Copyright © 2018 Dylan Steck. All rights reserved.
//

import UIKit

class TableViewCellCA: UITableViewCell{
    
    @IBOutlet weak var tvcTypeLabel: UILabel!
    @IBOutlet weak var tvcAmountLabel: UILabel!
    @IBOutlet weak var tvcDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
