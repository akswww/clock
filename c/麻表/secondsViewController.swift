//
//  secondsViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/28.
//

import UIKit

class secondsViewController: UIViewController {
    var tempTime: TimeInterval = 0.0
    var totalTime: TimeInterval = 0.0
    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    let stopwatch = Stopwatch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }
    
    func setUi() {
        startCount()
    }
    
    func startCount() {
        tempTime = TimeInterval(UserPerferences.shard.tempTime1)
        totalTime = stopwatch.elapsedTime + tempTime
        let minutes = Int(totalTime / 60)
        let seconds = Int(totalTime.truncatingRemainder(dividingBy: 60))
        let tenthsOfSecond = Int(totalTime * 100) % 100
        elapsedTimeLabel.text = String(format: "%02d:%02d.%02d",
            minutes, seconds, tenthsOfSecond)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self,
            selector: #selector(secondsViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
        
        if (!stopwatch.isRunning) {
            stopwatch.start()
        } else {
            tempTime = stopwatch.elapsedTime + tempTime
            stopwatch.stop()
            UserPerferences.shard.tempTime1 = Double(tempTime)
        }
        
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        
        tempTime = 0.0
        totalTime = 0.0
        UserPerferences.shard.tempTime1 = 0.0
        elapsedTimeLabel.text = "00:00.00"
        
    }
    
    @objc func updateElapsedTimeLabel(_ timer: Timer) {
        print(stopwatch.elapsedTime)
        if stopwatch.isRunning {
            startCount()
        } else {
            timer.invalidate()
        }
    }
    
}
