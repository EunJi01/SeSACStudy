//
//  TabBarController.swift
//  SeSACWeek7Diary
//
//  Created by 황은지 on 2022/08/27.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
        setupTabBarAppearence()
    }

    func configureTabBarController() {
        let firstVC = HomeViewController()
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondVC = SearchViewController()
        let thirdVC = SettingViewController()
        
        firstVC.tabBarItem = UITabBarItem(title: "달력", image: UIImage(systemName: "calendar.circle"), selectedImage: UIImage(systemName: "calendar.circle.fill"))
        secondVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        thirdVC.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape.circle"), selectedImage: UIImage(systemName: "gearshape.circle.fill"))
        
        setViewControllers([firstNav, secondVC, thirdVC], animated: true)
        hidesBottomBarWhenPushed = false // 네비게이션VC로 푸쉬했을 때 밑에 바가 사라지는 것을 방지
    }
    
    func setupTabBarAppearence() {
//        let appearence = UITabBarAppearance()
//        tabBar.tintColor = .black
    }
}
