//
//  TabBarController.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 13/04/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNavController = UINavigationController(rootViewController: HomeViewController())
        let upcomingNavController = UINavigationController(rootViewController: UpcomingViewController())
        let searchNavController = UINavigationController(rootViewController: SearchViewController())
        let downloadsNavController = UINavigationController(rootViewController: DownloadsViewController())
        
        homeNavController.tabBarItem.image = UIImage(systemName: "house")
        upcomingNavController.tabBarItem.image = UIImage(systemName: "play.circle")
        searchNavController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsNavController.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeNavController.title = "Home"
        upcomingNavController.title = "Coming Soon"
        searchNavController.title = "Top Search"
        downloadsNavController.title = "Downloads"
        
        setViewControllers([
            homeNavController,
            upcomingNavController,
            searchNavController,
            downloadsNavController
        ], animated: true)
    }
}
