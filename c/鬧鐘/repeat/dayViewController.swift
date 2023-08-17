//
//  dayViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/20.
//

import UIKit

class dayViewController: UIViewController,UINavigationBarDelegate {
    
    weak var updateData: updateData?
    
    var isSelected: [Int] = []
    var backButton: UIBarButtonItem?
    
    @IBOutlet weak var daytabel: UITableView!
    var day:[String] = ["星期六","星期日","星期一","禮拜二","星期三","星期四","星期五"]
    var day1:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        daytabel.register(UINib(nibName: "showdayTableViewCell", bundle: nil), forCellReuseIdentifier: showdayTableViewCell.idfile)
        daytabel.dataSource = self
        daytabel.delegate = self
        //        backButton = navigationItem(title: "back", style: .done, target: self, action: #selector(backClock))
        //        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func backClock(){
        dismiss(animated:true,completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension dayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: showdayTableViewCell.idfile, for: indexPath) as? showdayTableViewCell else{ return UITableViewCell() }
        
        cell.showDay.text = day[indexPath.row]
        cell.selectionStyle = .none
        
        // 判斷Cell是否有在陣列中，有則打勾，沒有則不打勾
        if isSelected.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 判斷目前點擊的Cell是否有儲存於陣列中，有存在陣列中代表有點擊過
        if self.isSelected.contains(indexPath.row) {
            // 若已選擇過，則將該index移除陣列內
            
            self.isSelected = self.isSelected.filter{$0 != indexPath.row}
        } else {
            // 若未選擇過，則將該index加入陣列中
            self.isSelected.append(indexPath.row)
        }
        
        
        //        daytabel.deselectRow(at: indexPath, animated: true)
        //        day1.append(day[isSelected[indexPath.row]])
        
        daytabel.reloadRows(at: [indexPath], with: .automatic)
        updateData?.updateData(data: day[indexPath.row], nick: isSelected)
    }
    
    
    
    
}
protocol updateData: AnyObject {
    func updateData(data: String, nick:[Int])
}
