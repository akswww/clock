

import UIKit

class worldViewController: UIViewController, UISearchBarDelegate {
    //MARK: - @IBoutlet
    @IBOutlet weak var worldTableview: UITableView!
    @IBOutlet weak var worldSearch: UISearchBar!
    
    //MARK: - Variables
    var timeZones = [String]()
    var jumpButton:UIBarButtonItem!
    var exitButton:UIBarButtonItem!
    var timer: Timer?
    weak var showTimeZoneDelegate:AddTimeZones?
   
    
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
    
    func setSearch() {
        worldSearch.delegate = self
        worldSearch.placeholder = "Choose City...."
        worldSearch.showsCancelButton = true
    }
    
    func setTableview() {
        worldTableview.delegate = self
        worldTableview.dataSource = self
    }
    
    func settable(){
        worldTableview.register(UINib(nibName: "worldTableViewCell", bundle: nil), forCellReuseIdentifier: worldTableViewCell.idfile)
    }
    
    func setUi(){
        timeZones = NSTimeZone.knownTimeZoneNames
        setSearch()
        setTableview()
        settable()
        Timer.scheduledTimer(timeInterval: 60, target: self,
            selector: #selector(update), userInfo: nil, repeats: true)
    }
  
    func counthour(indexPath:Int) -> Int {
        let now = Date()
        let now1 = Date()
        let formatter = DateFormatter()
        let formatter1 = DateFormatter()
        formatter1.timeZone = TimeZone(identifier: "Asia/Taipei")
        formatter.timeZone = TimeZone(identifier: timeZones[indexPath])
          let calendar = Calendar.current
        formatter.dateFormat = "HH:mm"
        formatter1.dateFormat = "HH:mm"
        let startDate = formatter.date(from: formatter.string(from: now))
        let endDate = formatter.date(from: formatter1.string(from: now1))
        
        let diff:DateComponents = calendar.dateComponents([.hour], from: startDate!, to: endDate!)
//        let dateString = formatter.string(from: now)
        return diff.hour!
    }
    
    @objc func update() {
        worldTableview.reloadData()
    }

}

//MARK: - Extension
extension worldViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: worldTableViewCell.idfile, for: indexPath) as? worldTableViewCell else{ return UITableViewCell() }
        
        cell.worldLbl.text  = timeZones[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let x:Int
         x = counthour(indexPath: indexPath.row)
        
         UserPerferences.shard.tempCity.append(timeZones[indexPath.row])
         
         UserPerferences.shard.tempGap.append("\(x)")
         
         showTimeZoneDelegate?.addTimeZone(addedTimeZone: timeZones[indexPath.row])
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          
          if searchBar.text != "" {
              timeZones = NSTimeZone.knownTimeZoneNames.filter({$0.contains(searchBar.text!)})
          }else{
              timeZones = NSTimeZone.knownTimeZoneNames
          }
          
          worldTableview.reloadData()
          
      }

      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          dismiss(animated: true, completion: nil)
      }
    
  
    
}

//MARK: - Protocol
protocol AddTimeZones:AnyObject {
    func addTimeZone(addedTimeZone:String)
}
