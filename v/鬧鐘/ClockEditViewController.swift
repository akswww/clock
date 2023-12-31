//
//  ClockEditViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/16.
//

import UIKit
import RealmSwift
class ClockEditViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var choceTime: UIPickerView!
    
    @IBOutlet weak var choceTable: UITableView!
    
    weak var updateAlarmLabelDelegate: UpdateAlarmLabelDelegate?
    
    var index:Int!
    
    var nickf:[Int] = []
    
    var musicf:String = ""
    
    var dataf:[String] = ["星期六","星期日","星期一","禮拜二","星期三","星期四","星期五"]
    
    let array:[String] = ["預設","好聽", "gary1132","gay"]
    
    var dayf:String = ""
    
    var seclectmusic:[Int] = []
    
    var addButton1: UIBarButtonItem?
    
    var exitButton1:UIBarButtonItem?
    
    var section1: Int? = nil
    
    var minute_select:Int = 0
    
    var  hour_select:Int = 0
    
    var getTime:Int = 0
    
    var qq: Bool = false
   
    var isText: String = ""

    var tempStr:String = ""
    
    var bb: Bool = false
    
    var test: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choceTime.delegate = self
        choceTime.dataSource = self
        print(hour_select)
        choceTime.selectRow(hour_select, inComponent: 0, animated: true)
        choceTime.selectRow(minute_select, inComponent: 1, animated: true)
        choceTime.reloadAllComponents()
        choceTable.register(UINib(nibName: "dataTableViewCell", bundle: nil), forCellReuseIdentifier: dataTableViewCell.idfile)
        choceTable.dataSource = self
        choceTable.delegate  = self
        choceTable.register(UINib(nibName: "textTableViewCell", bundle: nil), forCellReuseIdentifier: textTableViewCell.idfile)
        choceTable.register(UINib(nibName: "remindTableViewCell", bundle: nil), forCellReuseIdentifier: remindTableViewCell.idfile)
        
        addButton1 = UIBarButtonItem(title: "儲存", style: .done, target: self, action: #selector(addClock))
        navigationItem.rightBarButtonItem = addButton1
        
        exitButton1 = UIBarButtonItem(title: "退出", style: .done, target: self, action: #selector(exitClock))
        navigationItem.leftBarButtonItem = exitButton1
        choceTime.selectRow( ((time.time_shared.hour.count) * 1000) / 2, inComponent: 0, animated: false)
        
        
        disKey()
        
    }
    
    func setTime() -> Int {
        let now = Date()
        let timeInterval = now.timeIntervalSince1970
        return Int(timeInterval)
        
    }
    
    func disKey(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
    }
   
    @objc func dismissKeyBoard() {
            self.view.endEditing(true)
        }
    
    @objc func addClock(){
        
        switch qq {
        case false:
            let realm = try! Realm()
            let nick1 = List<Int>()
            nick1.append(objectsIn: nickf)
            
            let music = List<Int>()
            music.append(objectsIn: seclectmusic)
            let todo = RealmModel(hour: hour_select, min: minute_select, delTime: setTime(), swichStatus: true, delaySwich: true, whatMusic: musicf, whatDay: dayf, whattext: isText, nickff: nick1, selectMusic: music)
            
            try! realm.write {
                realm.add(todo)
            }
            
//            print("isText \(isText)")
            updateAlarmLabelDelegate?.updateAlarmLabel(hour: hour_select, min: minute_select, delTime: todo.delTime, clockison: true ,whatText: isText,whatMusic: musicf,whatDay: dayf,delaySwich: true, nickff: nickf, musicff: seclectmusic)
        case true:
            var f: [RealmModel] = []
            let realm = try! Realm()
            let todo = realm.objects(RealmModel.self)
            todo.forEach { item in
                f.append(RealmModel(hour: item.hour, min: item.min, delTime: item.delTime, swichStatus: item.swichStatus,delaySwich: item.delaySwich,whatMusic: item.whatMusic,whatDay: item.whatDay,whattext: item.whattext, nickff: item.nickff, selectMusic: item.selectMusic))
            }
            let nick1 = List<Int>()
            nick1.append(objectsIn: nickf)
            let predicate = NSPredicate(format: "delTime == \(getTime)")
            let dog = realm.objects(RealmModel.self).filter(predicate)
            
            let music = List<Int>()
            music.append(objectsIn: seclectmusic)
                       try! realm.write {
                           dog[0].hour = hour_select
                           dog[0].min = minute_select
                           dog[0].swichStatus = true
                           dog[0].whatDay = dayf
                           dog[0].whattext = isText
                           dog[0].whatMusic = musicf
                           dog[0].nickff = nick1
                           dog[0].selectMusic = music
                       }
           
            updateAlarmLabelDelegate?.updateAlarmLabel(hour: hour_select, min: minute_select, delTime: setTime() , clockison: true ,whatText: isText,whatMusic: musicf,whatDay: dayf,delaySwich: true, nickff: nickf, musicff: seclectmusic)
            qq = false
        }
        dismiss(animated:true,completion: nil)
    }
    
    @objc func exitClock(){
        dismiss(animated:true,completion: nil)
    }
    @objc func stateSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            var dateComponents = DateComponents()
                dateComponents.hour = hour_select
                dateComponents.minute = (minute_select + 1)
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
            var dateComponents = DateComponents()
                dateComponents.hour = hour_select
                dateComponents.minute = minute_select
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
        }
    }
    
}

extension ClockEditViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2   //    回傳行直列數
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (time.time_shared.hour.count) * 100
        } else {
            return (time.time_shared.minute.count) * 1000
        }
    }             //回傳每一直列的行列數（component 指的是選到哪個直列）
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if component == 0 {
            if time.time_shared.hour[row % time.time_shared.hour.count] < 10 {
                return "0\(time.time_shared.hour[row % time.time_shared.hour.count])"
            } else {
                return "\(time.time_shared.hour[row % time.time_shared.hour.count])"
            }
            
        } else {
            if time.time_shared.minute[row % time.time_shared.minute.count] < 10 {
                return "0\(time.time_shared.minute[row % time.time_shared.minute.count])"
            } else {
                return "\(time.time_shared.minute[row % time.time_shared.minute.count])"
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            
            let position1 = ((time.time_shared.hour.count) * 100) / 2 + row % time.time_shared.hour.count
               choceTime.selectRow(position1, inComponent: 0, animated: false)
            
            self.hour_select = time.time_shared.hour[row % time.time_shared.hour.count]
        } else if component == 1 {
            
            let position = ((time.time_shared.minute.count) * 1000) / 2 + row % time.time_shared.minute.count
               choceTime.selectRow(position, inComponent: 1, animated: false)
            
            self.minute_select = time.time_shared.minute[row % time.time_shared.minute.count]
        }
        
          
    }          //將選取的值放到 hour_select 變數和 minute_select變數
}

protocol UpdateAlarmLabelDelegate: AnyObject {
    func updateAlarmLabel(hour:Int, min:Int, delTime:Int,clockison:Bool,whatText:String,whatMusic:String,whatDay:String,delaySwich:Bool, nickff: [Int] , musicff: [Int])
}

extension ClockEditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section1  = section
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: dataTableViewCell.idfile, for: indexPath) as? dataTableViewCell else{ return UITableViewCell() }
            cell.repectLbl.text = "重複"
            cell.showdata.text = dayf
            return cell
        } else  if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textTableViewCell.idfile, for: indexPath) as? textTableViewCell else{ return UITableViewCell() }
            
            
            
            cell.textLbl.text = "標籤"
            var f: [RealmModel] = []
            let realm = try! Realm()
            let todo = realm.objects(RealmModel.self)
            todo.forEach { item in
                f.append(RealmModel(hour: item.hour, min: item.min, delTime: item.delTime, swichStatus: item.swichStatus,delaySwich: item.delaySwich,whatMusic: item.whatMusic,whatDay: item.whatDay,whattext: item.whattext, nickff: item.nickff, selectMusic: item.selectMusic))
            }
            
     
            cell.textFld.delegate = self
            switch bb {
            case false:
                if (cell.textFld.text == "") {
                    cell.textFld.text = "鬧鐘"
                    isText = "鬧鐘"
                    
                }

            case true:
                cell.textFld.text = isText

            }
            
          
            return cell
        } else if indexPath.row  == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: dataTableViewCell.idfile, for: indexPath) as? dataTableViewCell else{ return UITableViewCell() }
        
            cell.repectLbl.text = "提示聲"
            cell.showdata.text = musicf
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: remindTableViewCell.idfile, for: indexPath) as? remindTableViewCell else{ return UITableViewCell() }
            cell.remindLbl.text = "稍後提醒"
                    return cell
    }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let todataedit = dayViewController()
            todataedit.updateData = self
            let newBackButton = UIBarButtonItem()
            newBackButton.title = "返回"
            todataedit.isSelected = nickf
            navigationItem.backBarButtonItem = newBackButton
            navigationController?.pushViewController(todataedit, animated: true)
            
        } else if indexPath.row == 1 {
            
        } else if indexPath.row == 2{
            
            let tomusic = musicViewController()
            tomusic.upmusic = self
            let newBackButton = UIBarButtonItem()
            newBackButton.title = "返回"
            tomusic.seclect = seclectmusic
            navigationItem.backBarButtonItem = newBackButton
            navigationController?.pushViewController(tomusic, animated: true)
            
        } else {
            let toremind = remindTableViewCell()
            toremind.remindSth.addTarget(self, action: #selector(stateSwitch), for: .touchUpInside)
            
        }
    }

}

extension ClockEditViewController: updateData{
    func updateData(data: String, nick: [Int]) {
        
        dayf = ""
        for i in nick{
            dayf.append(dataf[i])
        }
        nickf = nick
        choceTable.reloadData()
    }
}
extension ClockEditViewController: upmusic {
    func upmusic(music: String, seclect1: [Int]) {
        seclectmusic = seclect1
        musicf = ""
        for i in seclect1 {
            musicf.append(array[i])
        }
        choceTable.reloadData()
    }

}

extension ClockEditViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if( textField.text == "鬧鐘") {
                    isText = "鬧鐘"
                } else {
                    isText = textField.text!
    }
}
}
