//
//  TabBarViewController.swift
//  DiaryWithRealm
//
//  Created by dong eun shin on 2022/01/09.
//
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let homeVC = HomeViewController()
        let savedVC = SavedViewController()
        
        homeVC.title = "Home"
        savedVC.title = "Saved"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let savedNav = UINavigationController(rootViewController: savedVC)
        
        setViewControllers([homeNav, savedNav], animated: true)
        
//        setViewControllers([homeVC, savedVC], animated: true)

    }
}
