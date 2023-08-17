//
//  ClockTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/20.
//

import UIKit

class ClockTableViewCell: UITableViewCell {
    @IBOutlet weak var tabLbl: UILabel!
    @IBOutlet weak var tabBtn: UIButton!
    static let idfile = "ClockTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
//        let clocktabelview = UITableView
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
