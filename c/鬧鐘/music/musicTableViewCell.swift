//
//  musicTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/21.
//

import UIKit

class musicTableViewCell: UITableViewCell {
    @IBOutlet weak var musicLbl: UILabel!
    static let idfile = "musicTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
