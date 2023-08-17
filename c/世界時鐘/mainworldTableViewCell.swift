//
//  mainworldTableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/31.
//

import UIKit

class mainworldTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLbl: UILabel!
    static let idfile = "mainworldTableViewCell"
    @IBOutlet weak var gmtDifference: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
