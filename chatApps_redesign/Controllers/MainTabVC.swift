//
//  MainTabVC.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = HomeVC()
        let profileVC = ProfileVC()
        
        let tableVC = UITabBarController()
        
        tableVC.viewControllers = [mainVC, profileVC]
        tableVC.selectedIndex = 0
        tableVC.selectedViewController = mainVC
    }
}
