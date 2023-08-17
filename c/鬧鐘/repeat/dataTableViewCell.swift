//
//  dataTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/20.
//

import UIKit

class dataTableViewCell: UITableViewCell {
   
    @IBOutlet weak var repectLbl: UILabel!
    @IBOutlet weak var showdata: UILabel!
    static let idfile = "dataTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

