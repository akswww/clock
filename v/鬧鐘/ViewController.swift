//
//  ViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/16.
//

import UIKit
import RealmSwift
import UserNotifications
import SwiftUI

class ViewController: UIViewController, UNUserNotificationCenterDelegate{
    
    @IBOutlet weak var clockTableview: UITableView!
    
    var clockisonf: Bool = true
    
    var hourf: Int = 0
    var minf: Int = 0
    
    var delTimef: Int = 0
    
    var f:[setTime] = []
    
    var selectIndexPath: Int? = nil
    
    var jumpButton: UIBarButtonItem?
    var exitButton: UIBarButtonItem?
    
    var LalelClock: UILabel?
    
    var whatTextf:String = ""
    var whatMusicf:String = ""
    var whatDayf:String = ""
    var delaySwichf:Bool!
    
    var index1:[Int] = []
    
    var clickEdit:Bool = false
    
    let currentDate = Date()
    
    let dateformatterHour = DateFormatter()
    let dateformatterMin = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setui()
    }
    
    func setRight() {
        for cell in clockTableview.visibleCells {
                      if let customCell = cell as? TableViewCell {
                          customCell.right.isHidden = true
                           customCell.open.isHidden = false
                      }
                  }
    }
    
    @objc func addClock() {
        
        hourf = Int(dateformatterHour.string(from: Date()))!
        minf = Int(dateformatterMin.string(from: Date()))!
        let toclockedit = ClockEditViewController()
        toclockedit.updateAlarmLabelDelegate = self
        toclockedit.hour_select = hourf
        toclockedit.minute_select = minf
        let nv = UINavigationController(rootViewController: toclockedit)
        present(nv, animated: true, completion: nil)
    }
    
    func setui() {
        setupTableView()
        fetchFromDB()
        setButton()
        setTimeFormat()
        setTitle()
        setRight()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        clockTableview.setEditing(editing, animated: true)
        if isEditing {
         
            
            for cell in clockTableview.visibleCells {
                          if let customCell = cell as? TableViewCell {
                              customCell.right.isHidden = false
                               customCell.open.isHidden = true
                          }
                      }
            
        } else {
            
            for cell in clockTableview.visibleCells {
                          if let customCell = cell as? TableViewCell {
                              customCell.right.isHidden = true
                              customCell.open.isHidden = false
                              
                          }
                      }
        }
      
    }
    
    func setTitle() {
        navigationController!.navigationBar.prefersLargeTitles = true
        title = "鬧鐘"
    }
    
   func  setTimeFormat() {
       dateformatterMin.dateFormat = "mm"
       dateformatterHour.dateFormat = "HH"
   }
    
    func setButton() {
        jumpButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addClock))
        navigationItem.rightBarButtonItem = jumpButton
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func setupTableView() {
        clockTableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.idfile)
        clockTableview.register(UINib(nibName: "ClockTableViewCell", bundle: nil), forCellReuseIdentifier: ClockTableViewCell.idfile)
        clockTableview.delegate = self
        clockTableview.dataSource = self
    }
    
    func fetchFromDB() {
        f = []
        let realm = try! Realm()
        //        print(realm.configuration.fileURL)
        let peoples = realm.objects(RealmModel.self)
        if peoples.count >= 0{
            for i in peoples {
                let ff = setTime(hour: i.hour,
                                 min: i.min,
                                 delTime: i.delTime,
                                 swichStaus: i.swichStatus,
                                 whatDay: i.whatDay,
                                 whatMusic: i.whatMusic,
                                 delaySwich: i.delaySwich,
                                 whattext: i.whattext, nickff: i.nickff, selectMusic: i.selectMusic)
                f.append(ff)
            }
//            print(realm.configuration.fileURL)
            clockTableview.reloadData()
        }
    }
    
    func makeNotification(){
        let today = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: today)
        let weekday = dateComponents.weekday!
        for i in index1{
            if (weekday == i){
                var dateComponents = DateComponents()
                dateComponents.hour = hourf
                dateComponents.minute = minf
                //这里最后让repeats为true表示每天的6点30分都会推送通知
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                //通知的内容
                let content = UNMutableNotificationContent()
                content.title = "通知的标题"
                content.body = "通知的内容"
                /* 需要注意这个自定义的提示音不能超过30秒，不然系统会播放默认声音 */
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName("ring.m4a"))
                
                //完成通知的设置
                let request = UNNotificationRequest(identifier: "通知名称", content: content, trigger: trigger)
                //添加我们的通知到UNUserNotificationCenter推送的队列里
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            } else {
                print("")
            }
        }
    }
    
    func deleteMessage(delTime:Int) {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "delTime == \(delTime)")
        print(predicate)
        let del = realm.objects(RealmModel.self).filter(predicate)
        try! realm.write {
            realm.delete(del)
        }
    }
    
    func jumpDel(indexPath: Int) {
        self.deleteMessage(delTime: self.f[indexPath].delTime)
        self.fetchFromDB()
    }
    
    
    @objc func changeopen(_ sender: UISwitch) {
        for i in 0 ... f.count - 1 {
            if i == sender.tag {
                if sender.isOn == true {
                    let realm = try! Realm()
                    let del = realm.objects(RealmModel.self)
                    try! realm.write {
                        del[sender.tag].swichStatus = true
                    }
                    makeNotification()
                } else {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["通知名称"])
                    let realm = try! Realm()
                    //                let predicate = NSPredicate(format: "delTime == \(switchT!)")
                    let del = realm.objects(RealmModel.self)
                    try! realm.write {
                        del[sender.tag].swichStatus = false
                    }
                }
            }
        }
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 2 {
            return true
        } else {
        return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
          
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1{
            return 0
        } else {
            return f.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "🛌睡眠｜起床鬧鐘"
        } else if section == 1 {
            return "沒有鬧鐘"
        } else {
            return "其他"
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let toclockedit = ClockEditViewController()
        toclockedit.updateAlarmLabelDelegate = self
        toclockedit.hour_select = f[indexPath.row].hour
        toclockedit.minute_select = f[indexPath.row].min
        toclockedit.isText = f[indexPath.row].whattext
        toclockedit.dayf = f[indexPath.row].whatDay
        toclockedit.musicf = f[indexPath.row].whatMusic
        toclockedit.qq = true
        toclockedit.bb = true
        toclockedit.nickf = Array(f[indexPath.row].nickff)
        toclockedit.seclectmusic = Array(f[indexPath.row].selectMusic)
        toclockedit.getTime = f[indexPath.row].delTime
        selectIndexPath = indexPath.row
        let nv = UINavigationController(rootViewController: toclockedit)
        present(nv, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let likeAction = UIContextualAction(style: .normal, title: "刪除") {
            (action, view, completionHandler) in
            self.jumpDel(indexPath: indexPath.row)
            self.fetchFromDB()
            completionHandler(true)
        }
        
        likeAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [likeAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.idfile, for: indexPath) as? TableViewCell else{ return UITableViewCell() }
            if ((f[indexPath.row].hour) < 10) {
            cell.clockHour.text =  "0\(f[indexPath.row].hour)"
            } else {
                cell.clockHour.text =  "\(f[indexPath.row].hour)"
            }
            if ((f[indexPath.row].min) < 10) {
                cell.clockMin.text = "0\(f[indexPath.row].min)"
            } else {
                cell.clockMin.text = "\(f[indexPath.row].min)"
            }
           
            cell.open.tag = indexPath.row
            cell.textLbl.text = "\(f[indexPath.row].whattext)"
            cell.weekLbl.text = "\(f[indexPath.row].whatDay)"
            cell.open.addTarget(self, action: #selector(changeopen), for: .touchUpInside)
            cell.open.isOn = f[indexPath.row].swichStaus
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ClockTableViewCell.idfile, for: indexPath) as? ClockTableViewCell else{ return UITableViewCell() }
            cell.tabLbl.text = "沒有鬧鐘"
            return cell
        }
        
    }
}

extension ViewController: UpdateAlarmLabelDelegate {
    func updateAlarmLabel(hour: Int, min: Int, delTime: Int, clockison: Bool, whatText: String, whatMusic: String, whatDay: String, delaySwich: Bool, nickff: [Int], musicff: [Int]) {
        
        self.hourf = hour
        self.minf = min
        self.delTimef = delTime
        self.clockisonf = true
        self.whatDayf = whatDay
        self.whatMusicf = whatMusic
        self.whatTextf = whatText
        self.delaySwichf = delaySwich
        self.index1 = nickff
        makeNotification()
        fetchFromDB()
        self.clockTableview.reloadData()
    }
   
    
    
}


