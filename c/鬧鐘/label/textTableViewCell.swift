//
//  textTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/21.
//

import UIKit

class textTableViewCell: UITableViewCell {
    @IBOutlet weak var textFld: UITextField!
    @IBOutlet weak var textLbl: UILabel!
    static let idfile = "textTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
