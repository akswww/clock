
import UIKit

class timerViewController: UIViewController {
    //MARK: - @IBoutlet
    @IBOutlet weak var showTimerLbl: UILabel!
    
    @IBOutlet weak var chocetimePk: UIPickerView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var musicTablecell: UITableViewCell!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    //MARK: - Variables
    var hour = [Int](0...23)
    var minute = [Int](0...59)
    var second = [Int](0...59)
    
    var hour_select: Int = 0
    var minute_select: Int = 0
    var sec_select:Int = 0
    
    var timer1: Timer!
    var isStop: Bool = true
    var isPaused: Bool = false
    
    var hour_count: Int = 0
    var min_count: Int = 0
    var sec_count:Int = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func stop() -> Bool {
        return isPaused
    }
    //MARK: - UI Settngs
    func setUi(){
        setPK()
        showTimerLbl.isHidden = true
    }
    
    func setPK() {
        chocetimePk.delegate = self
        chocetimePk.dataSource = self
        chocetimePk.selectRow(hour_select, inComponent: 0, animated: true)
        chocetimePk.selectRow(minute_select, inComponent: 1, animated: true)
        chocetimePk.selectRow(sec_select, inComponent: 2, animated: true)
        chocetimePk.reloadAllComponents()
    }
    
    func showPk() {
        chocetimePk.isHidden = false
        showTimerLbl.isHidden = true
    }
    
    func showLbl() {
        chocetimePk.isHidden = true
        showTimerLbl.isHidden = false
    }
    
    //MARK: - IBAction
    @IBAction func startBtn(_ sender: UIButton) {
        
        if (isStop){
            hour_count = hour_select
            min_count = minute_select
            sec_count = sec_select
            
            showLbl()
            isStop = false
            
        showTimerLbl.text = "\(hour_select)小時\(minute_select)分\(sec_select)秒"
            
        timer1 = Timer.scheduledTimer(timeInterval: 1, target: self,
                             selector: #selector(timerViewController.count), userInfo: nil, repeats: true)
            
        } else if (isPaused) { // paused
            
            timer1 = Timer.scheduledTimer(timeInterval: 1, target: self,
                                 selector: #selector(timerViewController.count), userInfo: nil, repeats: true)
            
            isPaused = false
        } else {
            // running
            isPaused = true
            timer1.invalidate()
        }
        
    }
    
    @IBAction func clearBtn(_ sender: UIButton) {
        
        timer1.invalidate()
        hour_count = 0
        min_count = 0
        sec_count = 0
        showTimerLbl.text = "\(hour_count)小時\(min_count)分\(sec_count)秒"
        showPk()
        isStop = true
        isPaused = false
        
    }
    
    @objc func count() {
        
        if (hour_count == 0 && min_count == 0 && sec_count == 0) {
            timer1.invalidate()
            isStop = true
            chocetimePk.isHidden = false
            showTimerLbl.isHidden = true
        }
        if (sec_count > 0) {
            sec_count -= 1
            
        } else if(sec_count == 0) {
            if(min_count == 0 && hour_count != 0) {
                hour_count -= 1
                min_count = 59
                sec_count = 59
            } else if(min_count != 0) {
                min_count -= 1
                sec_count = 59
            }
        }
        showTimerLbl.text = "\(hour_count)小時\(min_count)分\(sec_count)秒"
//      print("\(hour_count)小時\(min_count)分\(sec_count)秒")
    }
    
        
}

//MARK: - Extension
extension timerViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3   //    回傳行直列數
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        } else if component == 1{
            return minute.count
        } else {
            return second.count
        }
    }             
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if component == 0 {
            if hour[row] < 10 {
                return "0\(hour[row])"
            } else {
                return "\(hour[row])"
            }
        } else if component == 1{
            if minute[row] < 10 {
                return "0\(minute[row])"
            } else {
                return "\(minute[row])"
            }
        } else {
            if second[row] < 10 {
                return "0\(second[row])"
            } else {
                return "\(second[row])"
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.hour_select = hour[row]
        } else if component == 1 {
            self.minute_select = minute[row]
        } else if component == 2 {
            self.sec_select = second[row]
        }
    }
}


//MARK: - Protocol

