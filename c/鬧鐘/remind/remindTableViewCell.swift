//
//  remindTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/21.
//

import UIKit

class remindTableViewCell: UITableViewCell {
    @IBOutlet weak var remindLbl: UILabel!
    @IBOutlet weak var remindSth: UISwitch!
    static let idfile = "remindTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
