//
//  TableViewCell.swift
//  clock
//
//  Created by imac-1681 on 2023/7/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var clockMin: UILabel!
    @IBOutlet weak var clockHour: UILabel!
    
    @IBOutlet weak var right: UIImageView!
    @IBOutlet weak var open: UISwitch!
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var weekLbl: UILabel!
    
    var switchStatus: Bool!
    static let idfile = "TableViewCell"
//    var arrowImageView: UIImageView!
    
//
//    func addArrowSymbol() {
//            if arrowImageView == nil {
//                arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
//                arrowImageView?.tintColor = .black
//                arrowImageView?.translatesAutoresizingMaskIntoConstraints = false
//                contentView.addSubview(arrowImageView!)
//
//                // 設置約束
//                NSLayoutConstraint.activate([
//                    arrowImageView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
//                    arrowImageView!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//                ])
//            }
//        }
//
//        func removeArrowSymbol() {
//            arrowImageView?.removeFromSuperview()
//            arrowImageView = nil
//        }
//
//    func animateRightCell() {
//            UIView.animate(withDuration: 0.2, animations: {
//                // 在這裡設置您想要的動畫效果
//                // 例如，將cell的內容向右偏移一段距離
//                self.transform = CGAffineTransform(translationX: 20, y: 0)
//            }) { (_) in
//                // 動畫完成後的處理
//                // 這裡可以加入一些額外的動作或邏輯
//            }
//        }
//
        func animateLeftCell() {
            UIView.animate(withDuration: 0.2, animations: {
                // 在這裡設置您想要的動畫效果
                // 例如，將cell的內容向右偏移一段距離
//                self.transform = CGAffineTransform(translationX: 30, y: 0)
                self.transform = .identity
            }) { (_) in
                // 動畫完成後的處理
                // 這裡可以加入一些額外的動作或邏輯
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

