//
//  TabBarViewController.swift
//  clock
//
//  Created by imac-1681 on 2023/7/27.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        // Do any additional setup after loading the view.
    }

    private func setupTabs() {
        let wordtime = createNav(whit: "世界時間", and: UIImage(systemName: "house"), vc: mainworldViewController())
        
        let home = createNav(whit: "鬧鐘", and: UIImage(systemName: "house"), vc: ViewController())
        
        let seconds = createNav(whit: "碼表", and: UIImage(systemName: "house"), vc: secondsViewController())
      
        let timepiece = createNav(whit: "計時器", and: UIImage(systemName: "house"), vc: timerViewController())
        
        self.setViewControllers([wordtime,home,seconds,timepiece], animated: true)

    }

    private func createNav(whit title: String, and image:UIImage?, vc:UIViewController) -> UINavigationController {
         let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
        
    }
}
