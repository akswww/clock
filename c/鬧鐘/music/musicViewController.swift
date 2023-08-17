//
//  musicViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/21.
//

import UIKit

class musicViewController: UIViewController {
    
    var array:[String] = ["預設","好聽", "gary1132","gay"]
    
    var music:String = ""
    
    weak var upmusic:upmusic?
    
    var seclect:[Int] = []
    
    @IBOutlet weak var musicTabel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableview()
    }
    
    func setTableview() {
        musicTabel.register(UINib(nibName: "musicTableViewCell", bundle: nil), forCellReuseIdentifier: musicTableViewCell.idfile)
        musicTabel.dataSource = self
        musicTabel.delegate  = self
    }

}
extension musicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: musicTableViewCell.idfile, for: indexPath) as? musicTableViewCell else{ return UITableViewCell() }
        
        cell.musicLbl.text = array[indexPath.row]
        cell.selectionStyle = .none
       
        
         // 判斷Cell是否有在陣列中，有則打勾，沒有則不打勾
  if seclect.contains(indexPath.row) {
      
             cell.accessoryType = .checkmark
         } else {
             cell.accessoryType = .none
         }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.seclect.contains(indexPath.row) {
            
        } else {
            // 若未選擇過，則將該index加入陣列中
            self.seclect.removeAll()
            self.seclect.append(indexPath.row)
        }
        musicTabel.reloadData()
        upmusic?.upmusic(music: music, seclect1: seclect)
    }
    
}
protocol upmusic:AnyObject{
    func upmusic(music:String,seclect1:[Int])
}
