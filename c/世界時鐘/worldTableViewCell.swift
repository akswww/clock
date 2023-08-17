//
//  worldTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/31.
//

import UIKit

class worldTableViewCell: UITableViewCell {

    @IBOutlet weak var worldLbl: UILabel!
    static let idfile = "worldTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
