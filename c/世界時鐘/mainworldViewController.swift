
import UIKit

class mainworldViewController: UIViewController {
    //MARK: - @IBoutlet
    @IBOutlet weak var showTimetableview: UITableView!
    
    //MARK: - Variables
    var jumpButton:UIBarButtonItem!
    var exitButton:UIBarButtonItem!
    
    var addTimeZones = [String]()
    
    let timeFormatter = DateFormatter()
    
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
    
    //MARK: - UI Settngs
    func setUi(){
        setButton()
        settable()
        Timer.scheduledTimer(timeInterval: 1, target: self,
            selector: #selector(updatetime), userInfo: nil, repeats: true)
    }
    
    func setButton() {
        jumpButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addClock))
        navigationItem.rightBarButtonItem = jumpButton
        exitButton = UIBarButtonItem(title: "編輯", style: .done, target: self, action: #selector(exitClock))
        navigationItem.leftBarButtonItem = exitButton
    }
    
    func settable(){
        showTimetableview.register(UINib(nibName: "mainworldTableViewCell", bundle: nil), forCellReuseIdentifier: mainworldTableViewCell.idfile)
        showTimetableview.dataSource = self
        showTimetableview.delegate = self
    }
    
    
    @objc func exitClock(){
        
    }
    
    @objc func addClock() {
        let toclockedit = worldViewController()
        toclockedit.showTimeZoneDelegate = self
        let nv = UINavigationController(rootViewController: toclockedit)
        present(nv, animated: true, completion: nil)
    }
    @objc func updatetime() {
        showTimetableview.reloadData()
    }
    
    func update(indexPath: Int) -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: UserPerferences.shard.tempCity[indexPath])
        formatter.dateFormat = "HH:mm"
        let dateString = formatter.string(from: now)
       return dateString
        
    }
       
}
    
    
   
    
    //MARK: - IBAction


//MARK: - Extension
extension mainworldViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return  UserPerferences.shard.tempGap.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 100
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mainworldTableViewCell.idfile, for: indexPath) as! mainworldTableViewCell

        cell.gmtDifference.text = "離現在時間差\(UserPerferences.shard.tempGap[indexPath.row])小時"
        cell.timeLabel.text = update(indexPath: indexPath.row)
        cell.cityLbl.text = UserPerferences.shard.tempCity[indexPath.row].components(separatedBy: "/").last!
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let setTimeZoneVC = segue.destination as? worldViewController {
              
              setTimeZoneVC.showTimeZoneDelegate = self
          }
      }
      
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              
              UserPerferences.shard.tempGap.remove(at: indexPath.row)
              UserPerferences.shard.tempCity.remove(at: indexPath.row)
              showTimetableview.deleteRows(at: [indexPath], with: .fade)
              
          }
      }
    
}

extension mainworldViewController:AddTimeZones {
    
    func addTimeZone(addedTimeZone:String){
        addTimeZones.append(addedTimeZone)
        showTimetableview.reloadData()
    }
    
}
//MARK: - Protocol

